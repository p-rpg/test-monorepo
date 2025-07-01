const std = @import("std");
pub const c = @cImport({
    @cDefine("GLFW_INCLUDE_NONE", {});
    @cInclude("GLFW/glfw3.h");
});

fn error_callback(err: c_int, description: [*c]const u8) callconv(.C) void {
    std.debug.print("[{}] {s}\n", .{ err, description });
}

fn key_callback(window: ?*c.GLFWwindow, key: c_int, scancode: c_int, action: c_int, mods: c_int) callconv(.C) void {
    if (key == c.GLFW_KEY_ESCAPE and action == c.GLFW_PRESS) {
        c.glfwSetWindowShouldClose(window, c.GLFW_TRUE);
    }
    _ = scancode;
    _ = mods;
}

pub fn main() !void {
    _ = c.glfwSetErrorCallback(error_callback);
    if (c.glfwInit() == 0) {
        return anyerror.Call_glfwInit;
    }
    defer c.glfwTerminate();
    c.glfwWindowHint(c.GLFW_CLIENT_API, c.GLFW_NO_API);
    const window = c.glfwCreateWindow(640, 480, "p-rpg", null, null);
    if (window == null) {
        return anyerror.Call_glfwCreateWindow;
    }
    defer c.glfwDestroyWindow(window);
    _ = c.glfwSetKeyCallback(window, key_callback);
    while (c.glfwWindowShouldClose(window) == 0) {
        c.glfwPollEvents();
    }
}
