# kyoproenv

VSCode上のdevcontainerで競技プログラミング環境を行うためのコンテナを提供します。  
極力日本語環境で作業できるようにすることを目指しました。

## できること

* AtCoderで使用できる言語(の一部)を使用してソースコードをビルドし、実行する
  * (cpp) AtCoderで設定されているオプションを設定した、cpp20コマンドが使えるようになっています。
  * (py) 
* [online-judge-tools](https://github.com/online-judge-tools/oj/blob/master/README.ja.md) を使用する

## 必要なもの

* [VSCode](https://azure.microsoft.com/ja-jp/products/visual-studio-code)
* Docker
  * [Docker Desktop](https://www.docker.com/products/docker-desktop/)がおすすめ

## イメージ

| イメージ名             | 内容                                        |
|:----------------------|:--------------------------------------------|
| ywak/kyoproenv:cpp    | C++のビルド環境のみ                          |
| ywak/kyoproenv:python | pythonのビルド環境のみ                       |
| ywak/kyoproenv:cpppy  | C++のビルド環境とpythonのビルド環境 (おすすめ) |
| ywak/kyoproenv:golang | Golangのビルド環境のみ                       |
