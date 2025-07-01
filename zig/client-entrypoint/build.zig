const std = @import("std");
const builtin = @import("builtin");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const exe_mod = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    const exe = b.addExecutable(.{
        .name = "client-entrypoint",
        .root_module = exe_mod,
    });
    b.installArtifact(exe);

    const glfw = b.dependency("glfw", .{
        .target = target,
        .optimize = optimize,
    });
    exe.addIncludePath(glfw.path("include"));
    exe.linkLibrary(glfw.artifact("glfw"));
    if (builtin.target.os.tag == .linux or builtin.target.os.tag == .windows) {
        if (std.process.hasEnvVar(b.allocator, "VULKAN_SDK") catch unreachable) {
            const libraryPath = b.pathJoin(&.{ std.process.getEnvVarOwned(b.allocator, "VULKAN_SDK") catch unreachable, "Lib" });
            exe.addLibraryPath(.{ .src_path = .{ .owner = b, .sub_path = libraryPath } });
        }
        exe.linkSystemLibrary(if (builtin.target.os.tag == .windows) "vulkan-1" else "vulkan");
    } else if (builtin.target.os.tag == .macos) {
        // exe.addIncludePath(.{ .src_path = .{ .owner = b, .sub_path = "../../objective-c/client-main/include" } });
        // exe.addObjectFile(.{ .src_path = .{ .owner = b, .sub_path = "../../objective-c/client-main/build/libp_client_main.a" } });
        exe.linkFramework("Cocoa");
        exe.linkFramework("QuartzCore");
        exe.linkFramework("Metal");
    } else {
        @panic("Unsupported OS");
    }

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }
    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
    const exe_unit_tests = b.addTest(.{
        .root_module = exe_mod,
    });
    const run_exe_unit_tests = b.addRunArtifact(exe_unit_tests);
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_exe_unit_tests.step);
}
