## アーカイブファイルの解凍・展開

アーカイブファイルは、tarによりアーカイブ化され、gzipにより圧縮されています。
このアーカイブファイルを、以下のコマンドで解凍・展開します。

```
$ tar xzf FrontISTR_V50.tar.gz
```

本ソフトウェアをインストールする環境のtarコマンドがzオプションをサポートしていない場合は、以下のコマンドで解凍・展開します。

```
$ gzip –dc FrontISTR_V50.tar.gz | tar xf –
```

アーカイブファイルを解凍・展開すると、アーカイブを展開したディレクトリに `FrontISTR` というディレクトリが作成されます。
以下、このディレクトリを `${FSTRBUILDDIR}` と記します。


