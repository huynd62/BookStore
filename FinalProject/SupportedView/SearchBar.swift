//
//  SearchBar.swift
//  FinalProject
//
//  Created by Nguyễn Đức Huy on 9/22/20.
//

import SwiftUI

struct SearchBar : View{
    
    @State var show = false
    @State var txt = ""
    
    var body: some View {
        VStack(spacing:0){
            HStack{
                if !self.show{
                    Text("Books").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .font(.title)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    Spacer(minLength: 0)
                }
                
                HStack{
                    if self.show {
                        Image("search").padding(.horizontal,8)
                        
                        TextField("Search Books ", text: self.$txt)
                            .background(Color.white)
                        
                        Button(action:{
                            withAnimation {
                                self.show.toggle()
                            }
                            
                        }){
                            Image(systemName: "xmark").foregroundColor(.black)
                        }
                        .padding(.horizontal,8)
                    }
                    else{
                        Button(action:{
                            withAnimation{
                                self.show.toggle()
                            }
                        }){
                            Image("search")
                                .foregroundColor(.black)
                                .padding(10)
                            
                        }
                    }
                }.padding(self.show ? 10 : 0)
                .background(Color.white)
                .cornerRadius(20)
                
                
                
            }
            .padding(.top,(UIApplication.shared.windows.first?.safeAreaInsets.top)! + 15)
            .padding(.horizontal)
            .padding(.bottom,10)
            .background(Color.orange)
        
        }
        .edgesIgnoringSafeArea(.top)
    }
}
struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
    }
}
