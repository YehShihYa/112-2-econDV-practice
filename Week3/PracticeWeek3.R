#Example 1 Code：
ggplot(data=)+
  geom_point(mapping=aes(fill=COT (顏色分類), x=, y=))

#Example 2  Code：
ggplot(Data=df)+
  geom_point(mapping=aes(x= Slen, y= Swid , fill= species))+
  geom_abline(data=, mapping=aes (sloop=s,intercept=c,color=species ))#data=()：指定已分類好

plotly::ggplotly