<GameFile>
  <PropertyGroup Name="MainScene" Type="Scene" ID="44e66590-eb5e-4516-bbbf-3d8abeb19bbc" Version="3.10.0.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="0" Speed="1.0000">
        <Timeline ActionTag="-620718754" Property="Position">
          <PointFrame FrameIndex="0" X="11.9558" Y="-152.3208">
            <EasingData Type="0" />
          </PointFrame>
        </Timeline>
        <Timeline ActionTag="1634500752" Property="Position">
          <PointFrame FrameIndex="0" X="63.2396" Y="-318.6828">
            <EasingData Type="0" />
          </PointFrame>
        </Timeline>
        <Timeline ActionTag="-1800272218" Property="Position">
          <PointFrame FrameIndex="0" X="186.4238" Y="-318.5161">
            <EasingData Type="0" />
          </PointFrame>
        </Timeline>
        <Timeline ActionTag="-847601009" Property="Position">
          <PointFrame FrameIndex="0" X="186.4244" Y="-318.5155">
            <EasingData Type="0" />
          </PointFrame>
        </Timeline>
        <Timeline ActionTag="1397816888" Property="Position">
          <PointFrame FrameIndex="0" X="5.8077" Y="-243.2262">
            <EasingData Type="0" />
          </PointFrame>
        </Timeline>
        <Timeline ActionTag="757829756" Property="Position">
          <PointFrame FrameIndex="0" X="64.0988" Y="-261.7342">
            <EasingData Type="0" />
          </PointFrame>
        </Timeline>
      </Animation>
      <ObjectData Name="Scene" Tag="32" ctype="GameNodeObjectData">
        <Size X="1334.0000" Y="750.0000" />
        <Children>
          <AbstractNodeData Name="background" CanEdit="False" ActionTag="-2032899187" Tag="36" IconVisible="False" ctype="SpriteObjectData">
            <Size X="1334.0000" Y="750.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="667.0000" Y="375.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.5000" Y="0.5000" />
            <PreSize X="1.0000" Y="1.0000" />
            <FileData Type="Normal" Path="background/background_01.png" Plist="" />
            <BlendFunc Src="1" Dst="771" />
          </AbstractNodeData>
          <AbstractNodeData Name="node_player" CanEdit="False" ActionTag="1967223735" Tag="38" IconVisible="True" HorizontalEdge="LeftEdge" VerticalEdge="TopEdge" RightMargin="1334.0000" BottomMargin="750.0000" ctype="SingleNodeObjectData">
            <Size X="0.0000" Y="0.0000" />
            <Children>
              <AbstractNodeData Name="sp_player" ActionTag="706161989" Tag="37" IconVisible="False" HorizontalEdge="LeftEdge" VerticalEdge="TopEdge" RightMargin="-94.0000" BottomMargin="-94.0000" ctype="SpriteObjectData">
                <Size X="94.0000" Y="94.0000" />
                <AnchorPoint ScaleY="1.0000" />
                <Position />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <FileData Type="MarkedSubImage" Path="player/fs/profession_fs_1.png" Plist="player/fs/fs.plist" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="txt_name" ActionTag="-1164996243" Tag="14" IconVisible="False" LeftMargin="113.5002" RightMargin="-196.5002" TopMargin="11.5213" BottomMargin="-35.5213" FontSize="20" LabelText="天下第一" VerticalAlignmentType="VT_Center" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                <Size X="83.0000" Y="24.0000" />
                <AnchorPoint ScaleY="0.5000" />
                <Position X="113.5002" Y="-23.5213" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <FontResource Type="Normal" Path="msyh.ttf" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="txt_lv_name" ActionTag="1797505504" Tag="15" IconVisible="False" LeftMargin="117.6656" RightMargin="-200.6656" TopMargin="44.3694" BottomMargin="-68.3694" FontSize="20" LabelText="凡人一枚" VerticalAlignmentType="VT_Center" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                <Size X="83.0000" Y="24.0000" />
                <AnchorPoint ScaleY="0.5000" />
                <Position X="117.6656" Y="-56.3694" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <FontResource Type="Normal" Path="msyh.ttf" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="txt_title" ActionTag="1457256900" Tag="20" IconVisible="False" LeftMargin="114.4869" RightMargin="-177.4869" TopMargin="71.9204" BottomMargin="-95.9204" FontSize="20" LabelText="无称号" VerticalAlignmentType="VT_Center" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                <Size X="63.0000" Y="24.0000" />
                <AnchorPoint ScaleY="0.5000" />
                <Position X="114.4869" Y="-83.9204" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <FontResource Type="Normal" Path="msyh.ttf" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="txt_gold" ActionTag="-1846470394" Tag="21" IconVisible="False" LeftMargin="7.9297" RightMargin="-76.9297" TopMargin="105.2295" BottomMargin="-129.2295" FontSize="20" LabelText="财富: 0" VerticalAlignmentType="VT_Center" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                <Size X="69.0000" Y="24.0000" />
                <AnchorPoint ScaleY="0.5000" />
                <Position X="7.9297" Y="-117.2295" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <FontResource Type="Normal" Path="msyh.ttf" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="txt_fame" ActionTag="-620718754" Tag="24" IconVisible="False" LeftMargin="11.9558" RightMargin="-80.9558" TopMargin="140.3208" BottomMargin="-164.3208" FontSize="20" LabelText="名气: 0" VerticalAlignmentType="VT_Center" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                <Size X="69.0000" Y="24.0000" />
                <AnchorPoint ScaleY="0.5000" />
                <Position X="11.9558" Y="-152.3208" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <FontResource Type="Normal" Path="msyh.ttf" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="sp_body" ActionTag="1634500752" Tag="22" IconVisible="False" LeftMargin="16.2396" RightMargin="-110.2396" TopMargin="272.1828" BottomMargin="-365.1828" ctype="SpriteObjectData">
                <Size X="94.0000" Y="93.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="63.2396" Y="-318.6828" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <FileData Type="MarkedSubImage" Path="main_layer/body/body_1.png" Plist="main_layer/body/body.plist" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="sp_xf" ActionTag="-1800272218" Tag="40" IconVisible="False" LeftMargin="144.4238" RightMargin="-228.4238" TopMargin="276.5161" BottomMargin="-360.5161" ctype="SpriteObjectData">
                <Size X="84.0000" Y="84.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="186.4238" Y="-318.5161" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <FileData Type="MarkedSubImage" Path="xf_icon/xf_0.png" Plist="xf_icon/xf.plist" />
                <BlendFunc Src="770" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="sp_xf_frame" ActionTag="-847601009" Tag="39" IconVisible="False" LeftMargin="139.4244" RightMargin="-233.4244" TopMargin="271.5155" BottomMargin="-365.5155" ctype="SpriteObjectData">
                <Size X="94.0000" Y="94.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="186.4244" Y="-318.5155" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <FileData Type="MarkedSubImage" Path="xf_icon/xifa_non.png" Plist="xf_icon/xf.plist" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="txt_life" ActionTag="-1246045277" Tag="7" IconVisible="False" LeftMargin="3.9660" RightMargin="-55.9660" TopMargin="187.8775" BottomMargin="-213.8775" FontSize="22" LabelText="寿命: " ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                <Size X="52.0000" Y="26.0000" />
                <AnchorPoint ScaleY="0.5000" />
                <Position X="3.9660" Y="-200.8775" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <FontResource Type="Normal" Path="msyh.ttf" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="img_life_load_bg" ActionTag="-2025776706" Tag="13" IconVisible="False" LeftMargin="62.2581" RightMargin="-312.2581" TopMargin="189.3852" BottomMargin="-219.3852" LeftEage="162" RightEage="162" TopEage="14" BottomEage="14" Scale9OriginX="162" Scale9OriginY="14" Scale9Width="169" Scale9Height="15" ctype="ImageViewObjectData">
                <Size X="250.0000" Y="30.0000" />
                <Children>
                  <AbstractNodeData Name="load_life" CanEdit="False" ActionTag="1820479788" Tag="12" IconVisible="False" LeftMargin="7.1930" RightMargin="12.8070" TopMargin="6.5444" BottomMargin="9.4556" ProgressInfo="100" ctype="LoadingBarObjectData">
                    <Size X="230.0000" Y="14.0000" />
                    <AnchorPoint ScaleX="-0.0037" />
                    <Position X="6.3420" Y="9.4556" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.0254" Y="0.3152" />
                    <PreSize X="0.9200" Y="0.4667" />
                    <ImageFileData Type="MarkedSubImage" Path="main_layer/loadbar/au_progress_bar.png" Plist="main_layer/loadbar/loadbar.plist" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="txt_load" ActionTag="1769550370" Tag="14" IconVisible="False" LeftMargin="105.7400" RightMargin="104.2600" TopMargin="-1.4845" BottomMargin="2.4845" FontSize="24" LabelText="0/0" HorizontalAlignmentType="HT_Center" VerticalAlignmentType="VT_Center" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                    <Size X="41.0000" Y="31.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="125.7400" Y="16.9845" />
                    <Scale ScaleX="0.7708" ScaleY="0.5459" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5030" Y="0.5662" />
                    <PreSize X="0.1600" Y="0.9667" />
                    <FontResource Type="Normal" Path="msyh.ttf" Plist="" />
                    <OutlineColor A="255" R="0" G="90" B="255" />
                    <ShadowColor A="255" R="0" G="95" B="255" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint />
                <Position X="62.2581" Y="-219.3852" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <FileData Type="MarkedSubImage" Path="main_layer/loadbar/au_progress_bg.png" Plist="main_layer/loadbar/loadbar.plist" />
              </AbstractNodeData>
              <AbstractNodeData Name="txt_exp" ActionTag="1397816888" Tag="9" IconVisible="False" LeftMargin="5.8077" RightMargin="-57.8077" TopMargin="230.2262" BottomMargin="-256.2262" FontSize="22" LabelText="修为: " ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                <Size X="52.0000" Y="26.0000" />
                <AnchorPoint ScaleY="0.5000" />
                <Position X="5.8077" Y="-243.2262" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <FontResource Type="Normal" Path="msyh.ttf" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="img_exp_load_bg" ActionTag="757829756" Tag="10" IconVisible="False" LeftMargin="64.0988" RightMargin="-444.0988" TopMargin="231.7342" BottomMargin="-261.7342" LeftEage="162" RightEage="162" TopEage="14" BottomEage="14" Scale9OriginX="162" Scale9OriginY="14" Scale9Width="169" Scale9Height="15" ctype="ImageViewObjectData">
                <Size X="380.0000" Y="30.0000" />
                <Children>
                  <AbstractNodeData Name="load_exp" ActionTag="1515816292" Tag="11" IconVisible="False" LeftMargin="12.6264" RightMargin="20.3010" TopMargin="6.4849" BottomMargin="9.5151" ProgressInfo="100" ctype="LoadingBarObjectData">
                    <Size X="347.0726" Y="14.0000" />
                    <AnchorPoint ScaleX="-0.0037" />
                    <Position X="11.3422" Y="9.5151" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.0298" Y="0.3172" />
                    <PreSize X="0.9133" Y="0.4667" />
                    <ImageFileData Type="MarkedSubImage" Path="main_layer/loadbar/equipped_strengthen_modify03.png" Plist="main_layer/loadbar/loadbar.plist" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="txt_load" ActionTag="-1328899877" Tag="12" IconVisible="False" LeftMargin="169.5000" RightMargin="169.5000" TopMargin="-2.4845" BottomMargin="1.4845" FontSize="24" LabelText="0/0" HorizontalAlignmentType="HT_Center" VerticalAlignmentType="VT_Center" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                    <Size X="41.0000" Y="31.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="190.0000" Y="16.9845" />
                    <Scale ScaleX="0.7544" ScaleY="0.5459" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5000" Y="0.5662" />
                    <PreSize X="0.1079" Y="1.0333" />
                    <FontResource Type="Normal" Path="msyh.ttf" Plist="" />
                    <OutlineColor A="255" R="144" G="238" B="153" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint />
                <Position X="64.0988" Y="-261.7342" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <FileData Type="MarkedSubImage" Path="main_layer/loadbar/au_progress_bg.png" Plist="main_layer/loadbar/loadbar.plist" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint />
            <Position Y="750.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition Y="1.0000" />
            <PreSize X="0.0000" Y="0.0000" />
          </AbstractNodeData>
          <AbstractNodeData Name="scrollview_xf" CanEdit="False" ActionTag="1073911751" VisibleForFrame="False" Tag="25" IconVisible="False" HorizontalEdge="BothEdge" VerticalEdge="BottomEdge" LeftMargin="1048.6573" RightMargin="2.3427" TopMargin="1.0000" TouchEnable="True" ClipAble="True" BackColorAlpha="102" ComboBoxIndex="1" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" IsBounceEnabled="True" ScrollDirectionType="Vertical" ctype="ScrollViewObjectData">
            <Size X="283.0000" Y="749.0000" />
            <AnchorPoint />
            <Position X="1048.6573" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.7861" />
            <PreSize X="0.2121" Y="0.9987" />
            <SingleColor A="255" R="255" G="150" B="100" />
            <FirstColor A="255" R="255" G="150" B="100" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
            <InnerNodeSize Width="1334" Height="750" />
          </AbstractNodeData>
          <AbstractNodeData Name="node_bottom_option" ActionTag="-436681122" Tag="27" IconVisible="True" LeftMargin="1334.0000" TopMargin="750.0000" ctype="SingleNodeObjectData">
            <Size X="0.0000" Y="0.0000" />
            <Children>
              <AbstractNodeData Name="bt_randXb" ActionTag="-257830469" Tag="26" IconVisible="False" LeftMargin="-504.0698" RightMargin="395.0698" TopMargin="-447.3777" BottomMargin="338.3777" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="79" Scale9Height="87" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="109.0000" Y="109.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="-449.5698" Y="392.8777" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="MarkedSubImage" Path="main_layer/firpiont_btn_normal.png" Plist="main_layer/main_layer.plist" />
                <PressedFileData Type="MarkedSubImage" Path="main_layer/firpiont_btn_normal.png" Plist="main_layer/main_layer.plist" />
                <NormalFileData Type="MarkedSubImage" Path="main_layer/firpiont_btn_gray.png" Plist="main_layer/main_layer.plist" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint />
            <Position X="1334.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="1.0000" />
            <PreSize X="0.0000" Y="0.0000" />
          </AbstractNodeData>
          <AbstractNodeData Name="node_bottom_st" ActionTag="-984592171" Tag="30" IconVisible="True" LeftMargin="1334.0000" BottomMargin="750.0000" ctype="SingleNodeObjectData">
            <Size X="0.0000" Y="0.0000" />
            <Children>
              <AbstractNodeData Name="bt_bag" ActionTag="559810803" Tag="35" IconVisible="False" LeftMargin="-325.0647" RightMargin="191.0647" TopMargin="12.6949" BottomMargin="-76.6949" TouchEnable="True" FontSize="22" ButtonText="背包" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="16" Scale9Height="14" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="134.0000" Y="64.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="-258.0647" Y="-44.6949" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
                <PressedFileData Type="Default" Path="Default/Button_Press.png" Plist="" />
                <NormalFileData Type="Default" Path="Default/Button_Normal.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="bt_record" ActionTag="-252871632" Tag="33" IconVisible="False" LeftMargin="-170.6740" RightMargin="26.6740" TopMargin="9.1254" BottomMargin="-83.1254" TouchEnable="True" FontSize="22" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="114" Scale9Height="52" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="144.0000" Y="74.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="-98.6740" Y="-46.1254" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="MarkedSubImage" Path="main_layer/bt_record_2.png" Plist="main_layer/main_layer.plist" />
                <PressedFileData Type="MarkedSubImage" Path="main_layer/bt_record_2.png" Plist="main_layer/main_layer.plist" />
                <NormalFileData Type="MarkedSubImage" Path="main_layer/bt_record_1.png" Plist="main_layer/main_layer.plist" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint />
            <Position X="1334.0000" Y="750.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="1.0000" Y="1.0000" />
            <PreSize X="0.0000" Y="0.0000" />
          </AbstractNodeData>
        </Children>
      </ObjectData>
    </Content>
  </Content>
</GameFile>