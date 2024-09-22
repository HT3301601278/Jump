# Flutter 跳跃游戏

这是一个使用Flutter开发的简单跳跃游戏。玩家需要控制角色在平台间跳跃,获得尽可能高的分数。

## 功能

- 简单易上手的游戏玩法
- 可调节的游戏难度(平台速度、重力等)
- 分数记录
- 游戏结束界面
- 主菜单界面

## 安装

1. 确保您的开发环境中已安装Flutter。如果没有,请参考[Flutter官方文档](https://flutter.dev/docs/get-started/install)进行安装。

2. 克隆此仓库:
   ```
   git clone https://github.com/your-username/flutter-jump-game.git
   ```

3. 进入项目目录:
   ```
   cd flutter-jump-game
   ```

4. 获取依赖:
   ```
   flutter pub get
   ```

5. 运行应用:
   ```
   flutter run
   ```

## 如何游玩

- 在主菜单中,您可以选择开始游戏或调整游戏设置。
- 游戏中,点击屏幕使角色跳跃。
- 尽可能长时间保持在平台上,获得更高分数。
- 当角色掉落时,游戏结束。您可以选择重新开始或返回主菜单。

## 自定义

您可以通过修改以下参数来自定义游戏难度:

- `platformSpeed`: 控制平台移动速度
- `allowContinuousJump`: 是否允许连续跳跃
- `gravity`: 控制重力大小

## 贡献

欢迎提交问题和拉取请求。对于重大更改,请先开issue讨论您想要改变的内容。

## 许可

[MIT](https://choosealicense.com/licenses/mit/)