# z80oolong/dep -- 複数の Formula 及び Tap リポジトリに依存する各種雑多な Formula 群

## 概要

[Homebrew for Linux][BREW] とは、Linux の各ディストリビューションにおけるソースコードの取得及びビルドに基づいたパッケージ管理システムです。 [Homebrew for Linux][BREW] の使用により、ソースコードからのビルドに基づいたソフトウェアの導入を単純かつ容易に行うことが出来ます。

本 Tap リポジトリは、 ```z80oolong/tmux, z80oolong/eaw, z80oolong/vte, z80oolong/mlterm/mlterm ...``` 等の各種 Tap リポジトリにおいて、複数の Tap リポジトリ及び複数の Formula に依存する各種雑多な Formula 群を含む Tap リポジトリです。

なお、各種雑多な Formula が含まれるため、本 Tap リポジトリの各 Formula の詳細については割愛致します。どうか御了承下さい。

## 使用法

まず最初に、以下に示す Qiita の投稿及び Web ページの記述に基づいて、手元の端末に [Homebrew for Linux][BREW] を構築し、以下のように  ```brew tap``` コマンドを用いて本リポジトリを導入します。

- [thermes 氏][THER]による "[Linuxbrew のススメ][THBR]" の投稿
- [Homebrew for Linux の公式ページ][BREW]

そして、本リポジトリに含まれる Formula を以下のようにインストールします。

```
 $ brew tap z80oolong/dep
 $ brew install <formula>
```

なお、本リポジトリに含まれる Formula に関しては、```z80oolong/tmux, z80oolong/eaw, z80oolong/vte, z80oolong/mlterm/mlterm ...``` 等の各種 Tap リポジトリに同梱される Formula 等によって間接的に使用されます。

## 謝辞

[Homebrew for Linux][BREW] の導入に関しては、 [Homebrew for Linux の公式ページ][BREW] の他、 [thermes 氏][THER]による "[Homebrew for Linux のススメ][THBR]" 及び [Homebrew for Linux][BREW] 関連の各種資料を参考にしました。 [Homebrew for Linux の開発コミュニティ][BREW]及び[thermes 氏][THER]を始めとする各氏に心より感謝致します。

そして最後に、 [Homebrew for Linux][BREW] に関わる全ての皆様に心より感謝致します。

<!-- 外部リンク一覧 -->

[BREW]:https://linuxbrew.sh/
[THER]:https://qiita.com/thermes
[THBR]:https://qiita.com/thermes/items/926b478ff6e3758ecfea
