import 'package:flutter_test/flutter_test.dart';
import 'package:jump/game/game_screen.dart';

import 'package:jump/main.dart';

void main() {
  testWidgets('跳一跳游戏主界面测试', (WidgetTester tester) async {
    // 构建应用并触发一次帧渲染。
    await tester.pumpWidget(const JumpGameApp());

    // 验证初始分数显示为 0。
    expect(find.text('分数: 0'), findsOneWidget);
    expect(find.text('分数: 1'), findsNothing);

    // 由于跳一跳游戏没有 '+' 按钮，此处可以根据实际需求添加交互测试。
    // 例如，模拟点击屏幕跳跃角色等。

    // 示例：模拟点击屏幕跳跃
    await tester.tap(find.byType(GameScreen));
    await tester.pump();

    // 根据游戏逻辑，验证分数是否有变化或其他期望行为。
    // 这里假设每次跳跃分数增加 1。
    expect(find.text('分数: 1'), findsOneWidget);
  });
}