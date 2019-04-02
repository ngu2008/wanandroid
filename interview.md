# 一道面试题

> 分享一道面试题，结果有点出乎意料

代码如下：输出结果是什么？

    public class Test {

    public static void main(String[] args) {
        Set<Short> stack = new HashSet<>();
        for (Short i = 0; i < 100; i++) {
            stack.add(i);
            stack.remove(i - 1);
        }
        System.out.println(stack.size());
    }

- 答案是100，i-1这里用到了隐式类型转换i-1会转成int型的减法，所以在remove时，根本没有那个对象，所以无论怎么调stack.remove(i-1)都不会有元素移出,所以答案是100.