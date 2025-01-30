//
//  ContentView.swift
//  SnackScope
//
//  Created by Dev Tech on 2025/01/17.
//

import SwiftUI

struct ContentView: View {
    // SnackDataを参照する変数
    var snackDataList = SnackData()
    
    // 入力された文字列を保持する状態変数
    @State var inputText = ""
    // SafariViewの表示有無を管理する変数
    @State var isShowSafari = false
    
    // 垂直縦方向にレイアウト
    var body: some View {

            VStack {
                
                // 文字を受け取るTextFieldを表示
                Text(inputText)
                    .font(.system(.title, design:.monospaced))
                    
                TextField("キーワード",
                          text: $inputText,
                          prompt: Text("検索するキーワードを入力してください"))
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    // 入力完了直後に検索
                    snackDataList.searchSnack(keyword: inputText)
                    
                } // .onSubmit End
                // キーボードの改行を検索に変更
                .submitLabel(.search)
                // 上下左右に空白を追加
                .padding()
                
                // リスト表示
                List(snackDataList.snackList) { snack in
                    // 要素ごとに取り出す
                    // ボタンを用意
                    Button {
                        // 選択したリンク保存
                        snackDataList.snackLink = snack.link
                        // SafariViewを表示
                        isShowSafari.toggle()
                    } label: {
                        // List表示内容生成
                        // 水平レイアウト（横方向）
                        HStack {
                            // 画像読み込み、表示
                            AsyncImage(url: snack.image) { image in
                                // 画像表示
                                image
                                // リサイズ
                                    .resizable()
                                // アスペクト比を維持し、画面内に収める
                                    .scaledToFit()
                                // 高さ
                                    .frame(width: 80, height: 80)
                            } placeholder: {
                                // 読み込み中インジケーター表示
                                ProgressView()
                                
                            } // AsyncImage End
                            // テキスト表示
                            Text(snack.maker)
                            Text(snack.name)
                        } // HStack End
                    } // Botton End
                } // List End
                .sheet(isPresented: $isShowSafari, content: {
                    // SafariViewを表示
                    SafariView(url: snackDataList.snackLink!)
                    // 画面下部セーフエリア外まで収まるよう指定
                        .ignoresSafeArea(edges: [.bottom])
                }) // sheet End
                
                Text("SNACKSCOPE")
                    .font(.headline)
                    .fontWeight(.black)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .underline(color: Color.purple)
                    .kerning(10)
                
            } // VStack End
    } // body End
} // ContentView End

#Preview {
    ContentView()
} // Preview End
