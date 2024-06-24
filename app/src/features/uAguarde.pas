unit uAguarde;

interface

uses System.SysUtils, System.UITypes, FMX.Types, FMX.Controls, FMX.StdCtrls,
  FMX.Objects, FMX.Effects, FMX.Layouts, FMX.Forms, FMX.Graphics, FMX.Ani,
  FMX.VirtualKeyboard, FMX.Platform, FMX.Skia;

type
  TModo = (Aguarde, Finalizado, Imprimindo, Dinheiro, Comprovante, Erro);

type
  TAguarde = class
  private
    class var FLyt: TLayout;
    class var FFundo: TRectangle;
    class var FRectSVG: TRoundRect;
    class var FArco: TArc;
    class var FMsg: TSKlabel;
    class var FMsgDescricao: TSKLabel;
    class var FAnimacao: TFloatAnimation;
    class var FSvg: TSkSvg;
  public
    class procedure Start(const AFrm: Tform; const AMsgTitulo: string;
                          const AMsgDescricao: string; Amodo: TModo;
                          ACorFundo: Cardinal = $FF333075; ACorFonte: Cardinal = $FFFEFFFF;
                          ACorArco: Cardinal = $FFE400E4; ACorCirculo: Cardinal = $FFFEFFFF);
    class procedure Hide;
    class procedure ChangeText(ATitutlo,ASubtitulo: string;Amodo: TModo); static;
  end;

const
  cCarregando =
    '<svg width="91" height="130" viewBox="0 0 91 130" fill="none" xmlns="http://www.w3.org/2000/svg">'
    + '<g id="Group 201">' +
    '<path id="Vector" d="M83.6575 10.0154C83.6575 10.0154 90.7098 44.9981 52.3802 62.9676C48.1568 64.9598 43.1763 64.9598 38.9529 62.9676C0.663093'
    + ' 45.038 7.71542 10.0154 7.71542 10.0154" stroke="#E400E4" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>'
    + '<path id="Vector_2" d="M7.71562 118.908C7.71562 118.908 0.663291 83.9256 38.9929 65.9561C43.2164 63.9639 48.1968 63.9639 52.4202 65.9561C90.7499 83.8857'
    + ' 83.6975 118.908 83.6975 118.908" stroke="#E400E4" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>'
    + '<path id="Vector_3" d="M12.7759 39.3009C12.7759 39.3009 26.1634 41.2134 41.9813 35.5954C65.0906 27.3876 79.5937 35.5954 79.5937 35.5954" stroke="#E400E4"'
    + ' stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>' +
    '<path id="Vector_4" d="M89.8733 119.984H1.5V128.75H89.8733V119.984Z" stroke="#E400E4" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>'
    + '<path id="Vector_5" d="M89.8733 1.25H1.5V10.0156H89.8733V1.25Z" stroke="#E400E4" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>'
    + '<path id="Vector_6" d="M16.9194 119.984C16.9194 113.49 29.7889 105.76 45.6866 105.76C61.5842 105.76 74.4537 113.49 74.4537 119.984" stroke="#E400E4"'
    + ' stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>' +
    '</g>' + '</svg>';

  cFinalizado =
    '<svg width="159" height="159" viewBox="0 0 159 159" fill="none" xmlns="http://www.w3.org/2000/svg">'
    +' <g id="Group 78">'
    +' <path id="Vector" d="M79.5 3.09375C121.714 3.09375 155.906 37.2855 155.906 79.5C155.906 121.714 121.714 155.906 79.5 155.906C37.2855 155.906 3.09375 121.714 3.09375 79.5C3.09375 37.2855 37.2855 3.09375 79.5 3.09375Z" stroke="white" stroke-width="5"/>'
    +' <path id="Vector_2" d="M45.2141 76.3963L70.1417 101.324L113.789 57.6767" stroke="white" stroke-width="5" stroke-linecap="round" stroke-linejoin="round"/>'
    +' </g>'
    +' </svg>';

  cImprimindo =
    '<svg width="130" height="129" viewBox="0 0 130 129" fill="none" xmlns="http://www.w3.org/2000/svg">'
    +'<g id="Group 498">'
    +'<path id="Vector" d="M101.457 54.8V19.618C101.457 17.7852 100.78 16.032 99.6241 14.757L89.1053 3.28203C87.91 2.00703 86.3163 1.25 84.6428 1.25H33.8022C30.8936 1.25 28.5428 3.83984 28.5428 7.02734V54.8"'
    +' stroke="#E400E4" stroke-width="2" stroke-linecap="round"/>'
    +'<path id="Vector_2" d="M100.302 21.7695H87.9899C86.3164 21.7695 85.0016 20.0961 85.0016 18.0242V2.20621" stroke="#E400E4" stroke-width="2" stroke-linecap="round"/>'
    +'<path id="Vector_3" d="M23.4031 108.749H6.35C3.52109 108.749 1.25 106.478 1.25 103.649V70.7379C1.25 62.291 8.10313 55.4379 16.55 55.4379H113.45C121.897 55.4379 128.75 62.291 128.75 70.7379V103.649C128.75 106.478 126.479 108.749 123.65 108.749H106.796"'
    +' stroke="#E400E4" stroke-width="2" stroke-linecap="round"/>'
    +'<path id="Vector_4" d="M19.4985 96.8746C17.7055 96.8746 16.2313 95.4003 16.2313 93.6074V86.7543C16.2313 84.9613 17.7055 83.4871 19.4985 83.4871H110.541C112.334 83.4871 113.809 84.9613 113.809 86.7543V93.6074C113.809'
    +' 95.4003 112.334 96.8746 110.541 96.8746"'
    +' stroke="#E400E4" stroke-width="2" stroke-linecap="round"/>'
    +'<path id="Vector_5" d="M103.051 84.0056L108.788 121.857C109.267 125.084 106.756 127.993 103.489 127.993H26.5111C23.204 127.993 20.6939 125.005 21.2517 121.777L27.5868 84.0056" stroke="#E400E4" stroke-width="2" stroke-linecap="round"/>'
    +'<path id="Vector_6" d="M108.828 71.8931C111.227 71.8931 113.171 69.9487 113.171 67.5502C113.171 65.1516 111.227 63.2072 108.828 63.2072C106.43 63.2072 104.485 65.1516 104.485 67.5502C104.485 69.9487 106.43 71.8931 108.828 71.8931Z"'
    +' stroke="#E400E4" stroke-width="2" stroke-linecap="round"/> '
    +'</g>'
    +'</svg>';

  cDinheiro =
    '<svg width="130" height="87" viewBox="0 0 130 87" fill="none" xmlns="http://www.w3.org/2000/svg">'
    + '<g id="Group 209">' +
    '<path id="Vector" d="M108.796 21.574H5.87219C3.31943 21.574 1.25 23.6434 1.25 26.1962V73.0556C1.25 75.6084 3.31943 77.6778 5.87219 77.6778H108.796C111.348 77.6778 113.418 75.6084 113.418 73.0556V26.1962C113.418 23.6434 111.348 21.574 108.796 21.574Z"'
    + 'stroke="#E400E4" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>'
    + '<path id="Vector_2" d="M51.8153 78.0763L27.1104 85.7666C24.7994 86.4839 22.3687 85.2088 21.6515 82.8977L20.0576 77.7177" stroke="#E400E4" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>'
    + '<path id="Vector_3" d="M45.001 21.4544L108.516 1.73036C111.226 0.893583 114.095 2.40775 114.932 5.11731L128.519 48.8688C129.356 51.5783 127.842 54.4473 125.132 55.284L113.417 58.9101" stroke="#E400E4" stroke-width="2" stroke-linecap="round"'
    + ' stroke-linejoin="round"/>' +
    '<path id="Vector_4" d="M58.549 41.5769C60.5413 42.1348 61.7765 43.37 62.4938 45.2428C62.8524 46.2389 62.6531 46.9163 61.8961 47.1953C61.1788 47.4742 60.5811 47.1554 60.2225 46.1593C59.306 43.4895 56.3972 43.4895 55.162 44.8443C54.8432 45.2029'
    + ' 54.5643 45.6412 54.4049' +
    ' 46.0796C54.0065 47.3945 54.4049 47.9922 55.68 48.2711C56.8754 48.5102 58.0708 48.5899 59.2662 48.829C62.3344 49.4267 63.6095 51.8972 62.3742 54.8059C61.7367 56.2803 60.6608 57.3163 59.1467 57.8343C58.6685 57.9937 58.5091 58.1929 58.5091'
    + ' 58.7109C58.5091 59.7071 58.0708' +
    ' 60.2649 57.2739 60.2649C56.4769 60.2649 56.0386 59.7071 56.0386 58.7109C56.0386 58.2327 55.9191 57.9937 55.4409 57.8343C53.7275 57.2366 52.6517 55.9216 52.054 54.2481C51.7352 53.3715 52.054 52.7339 52.7712 52.455C53.4884 52.2159 54.0065 52.4948'
    + ' 54.3651 53.3715C55.162 55.2443' +
    ' 56.4371 56.0412 58.0708 55.6427C58.9076 55.4435 59.585 54.9653 59.9436 54.1684C60.5413 52.8933 60.6608 51.6182 58.6685 51.3393C57.5129 51.1799 56.3176 51.0604 55.162 50.8213C52.2931 50.2236 51.0578 47.9125 52.0938 45.0834C52.6915 43.4497'
    + ' 53.8471 42.334 55.4808' +
    ' 41.7761C55.9589 41.6168 56.0785 41.3777 56.0386 40.9394C56.0386 40.7003 56.0386 40.4214 56.0386 40.1424C56.1183 39.465 56.5168 39.0666 57.1942 39.0267C57.8716 38.9869 58.3896 39.465 58.4693 40.1424C58.5091'
    + ' 40.6206 58.4693 41.0589 58.4693 41.5769H58.549Z" fill="#E400E4"/> ' +
    '<path id="Vector_5" d="M74.1289 49.6258C74.1289 58.9101 66.5979 66.4012 57.3535 66.4012C48.1091 66.4012 40.5781 58.8702 40.5781 49.6258C40.5781 40.3815 48.1091 32.8505 57.3535 32.8505C66.5979 32.8505 74.1289'
    + ' 40.3815 74.1289 49.6258Z" stroke="#E400E4" stroke-width="2"' +
    ' stroke-linecap="round" stroke-linejoin="round"/>' +
    '<path id="Vector_6" d="M101.504 21.574C101.504 28.1486 106.843 33.4881 113.418 33.4881" stroke="#E400E4" stroke-width="2" stroke-miterlimit="10"/>'
    + '<path id="Vector_7" d="M113.418 65.7637C106.843 65.7637 101.504 71.1031 101.504 77.6778" stroke="#E400E4" stroke-width="2" stroke-miterlimit="10"/>'
    + '<path id="Vector_8" d="M13.1641 77.6778C13.1641 71.1031 7.82467 65.7637 1.25 65.7637" stroke="#E400E4" stroke-width="2" stroke-miterlimit="10"/>'
    + '<path id="Vector_9" d="M1.25 33.4881C7.82467 33.4881 13.1641 28.1486 13.1641 21.574" stroke="#E400E4" stroke-width="2" stroke-miterlimit="10"/>'
    + '<path id="Vector_10" d="M15.3955 49.6256H27.3495" stroke="#E400E4" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>'
    + '<path id="Vector_11" d="M87.3584 49.6256H99.2725" stroke="#E400E4" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>'
    + '</g>' + '</svg>';

  cComprovante =
    '<svg width="130" height="87" viewBox="0 0 130 87" fill="none" xmlns="http://www.w3.org/2000/svg">'
    +'<g id="Group 209">'
    +'<path id="Vector" d="M108.796 21.574H5.87219C3.31943 21.574 1.25 23.6434 1.25 26.1962V73.0556C1.25 75.6084 3.31943 77.6778 5.87219 77.6778H108.796C111.348 77.6778 113.418 75.6084'
    + '113.418 73.0556V26.1962C113.418 23.6434 111.348 21.574 108.796 21.574Z" stroke="#E400E4" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>'
    +'<path id="Vector_2" d="M51.8153 78.0763L27.1104 85.7666C24.7994 86.4839 22.3687 85.2088 21.6515 82.8977L20.0576 77.7177" stroke="#E400E4" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>'
    +'<path id="Vector_3" d="M45.001 21.4544L108.516 1.73036C111.226 0.893583 114.095 2.40775 114.932 5.11731L128.519 48.8688C129.356 51.5783 127.842 54.4473 125.132 55.284L113.417 58.9101" stroke="#E400E4" stroke-width="2"'
    +' stroke-linecap="round" stroke-linejoin="round"/>'
    +'<path id="Vector_4" d="M58.549 41.5769C60.5413 42.1348 61.7765 43.37 62.4938 45.2428C62.8524 46.2389 62.6531 46.9163 61.8961 47.1953C61.1788 47.4742 60.5811 47.1554 60.2225'
    +' 46.1593C59.306 43.4895 56.3972 43.4895 55.162 44.8443C54.8432 45.2029 54.5643 45.6412 54.4049 46.0796C54.0065 47.3945 54.4049 47.9922 55.68 48.2711C56.8754 48.5102 58.0708 48.5899 59.2662'
    +' 48.829C62.3344 49.4267 63.6095 51.8972 62.3742 54.8059C61.7367 56.2803 60.6608 57.3163 59.1467 57.8343C58.6685 57.9937 58.5091 58.1929 58.5091 58.7109C58.5091 59.7071 58.0708 60.2649 57.2739'
    +' 60.2649C56.4769 60.2649 56.0386 59.7071 56.0386 58.7109C56.0386 58.2327 55.9191 57.9937 55.4409 57.8343C53.7275 57.2366 52.6517 55.9216 52.054 54.2481C51.7352 53.3715 52.054 52.7339 52.7712 52.455C53.4884 52.2159 54.0065 52.4948 54.3651'
    +' 53.3715C55.162 55.2443 56.4371 56.0412 58.0708 55.6427C58.9076 55.4435 59.585 54.9653 59.9436 54.1684C60.5413 52.8933 60.6608 51.6182 58.6685 51.3393C57.5129 51.1799 56.3176 51.0604 55.162 50.8213C52.2931 50.2236 51.0578 47.9125 52.0938'
    +' 45.0834C52.6915 43.4497 53.8471 42.334 55.4808 41.7761C55.9589 41.6168 56.0785 41.3777 56.0386 40.9394C56.0386 40.7003 56.0386 40.4214 56.0386 40.1424C56.1183 39.465 56.5168 39.0666 57.1942 39.0267C57.8716 38.9869 58.3896 39.465 58.4693'
    +' 40.1424C58.5091 40.6206 58.4693 41.0589 58.4693 41.5769H58.549Z" fill="#E400E4"/>'
    +'<path id="Vector_5" d="M74.1289 49.6258C74.1289 58.9101 66.5979 66.4012 57.3535 66.4012C48.1091 66.4012 40.5781 58.8702 40.5781 49.6258C40.5781 40.3815 48.1091 32.8505 57.3535 32.8505C66.5979'
    +' 32.8505 74.1289 40.3815 74.1289 49.6258Z" stroke="#E400E4" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>'
    +'<path id="Vector_6" d="M101.504 21.574C101.504 28.1486 106.843 33.4881 113.418 33.4881" stroke="#E400E4" stroke-width="2" stroke-miterlimit="10"/>'
    +'<path id="Vector_7" d="M113.418 65.7637C106.843 65.7637 101.504 71.1031 101.504 77.6778" stroke="#E400E4" stroke-width="2" stroke-miterlimit="10"/>'
    +'<path id="Vector_8" d="M13.1641 77.6778C13.1641 71.1031 7.82467 65.7637 1.25 65.7637" stroke="#E400E4" stroke-width="2" stroke-miterlimit="10"/>'
    +'<path id="Vector_9" d="M1.25 33.4881C7.82467 33.4881 13.1641 28.1486 13.1641 21.574" stroke="#E400E4" stroke-width="2" stroke-miterlimit="10"/>'
    +'<path id="Vector_10" d="M15.3955 49.6256H27.3495" stroke="#E400E4" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>'
    +'<path id="Vector_11" d="M87.3584 49.6256H99.2725" stroke="#E400E4" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>'
    +'</g>'
    +'</svg>';

  cErro =
    ' <svg version="1.0" xmlns="http://www.w3.org/2000/svg"'
    +'  width="512.000000pt" height="512.000000pt" viewBox="0 0 512.000000 512.000000"'
    +'  preserveAspectRatio="xMidYMid meet">'
    +'  <g transform="translate(0.000000,512.000000) scale(0.100000,-0.100000)"'
    +'  fill="#000000" stroke="none">'
    +'<path d="M2330 5110 c-322 -31 -646 -125 -928 -269 -259 -133 -429 -258 -647'
    +'-476 -230 -229 -352 -399 -490 -680 -121 -246 -192 -469 -237 -745 -31 -195'
    +'-31 -565 0 -760 45 -276 116 -499 237 -745 138 -281 260 -451 490 -680 229'
    +' -230 399 -352 680 -490 246 -121 469 -192 745 -237 195 -31 565 -31 760 0 276'
    +' 45 499 116 745 237 281 138 451 260 680 490 230 229 352 399 490 680 88 179'
    +' 132 296 180 476 63 240 78 371 78 649 0 278 -15 409 -78 649 -48 180 -92 297'
    +' -180 476 -138 281 -260 451 -490 680 -229 230 -399 352 -680 490 -246 121'
    +' -473 193 -740 235 -147 23 -475 34 -615 20z m456 -261 c434 -42 866 -219 1214'
    +' -497 540 -432 860 -1100 860 -1792 0 -606 -245 -1195 -675 -1625 -430 -430'
    +' -1019 -675 -1625 -675 -606 0 -1195 245 -1625 675 -430 430 -675 1019 -675'
    +'  1625 0 692 320 1360 860 1792 342 273 781 455 1200 497 125 12 341 13 466 0z"/>'
    +'  <path d="M1665 3526 c-37 -16 -53 -35 -65 -77 -21 -72 -16 -79 395 -489 l385'
    +'  -385 -385 -385 c-411 -411 -415 -416 -395 -490 17 -63 74 -96 145 -84 37 6 73'
    +' 39 428 392 l387 386 388 -386 c354 -353 390 -386 427 -392 71 -12 128 21 145'
    +' 84 20 74 16 79 -395 490 l-385 385 385 385 c412 411 415 416 395 491 -17 62'
    +' -74 95 -145 83 -37 -6 -73 -39 -427 -392 l-388 -386 -387 385 c-318 317 -394'
    +' 387 -422 393 -44 8 -51 7 -86 -8z"/>'
    +' </g>'
    +' </svg>';

  cCorFundo = $FF333075;
  cCorRectSVG = $FFFEFFFF;
  cSvgFinalizado = $000FC716;
  cSvgDinheiro = $000FC716;
  cSvg = $FFE400E4;
  cSvgErro = $000FC716;

implementation

{ TAguarde }

class procedure TAguarde.ChangeText(ATitutlo,ASubtitulo: string;Amodo: TModo);
begin
  if Assigned(FLyt) then                 
  begin
    try
      if Assigned(FMsg) then
        FMsg.Text := ATitutlo;

      if Assigned(FMsgDescricao) then
        FMsgDescricao.Text := ASubtitulo;

      if Assigned(FSvg) then
      begin
        if Amodo = TModo.Imprimindo then
          FSvg.Svg.Source := cImprimindo;
        if Amodo = TModo.Erro then
        begin
          FSvg.Svg.Source := cErro;
          FArco.Visible := false;
          FRectSVG.Fill.Color := cSvg;
          FSvg.Svg.OverrideColor := $FFFFFFFF;
        end;
        if Amodo = TModo.Finalizado then
        begin
          FSvg.Svg.Source := cFinalizado;
          FArco.Visible := false;
          FRectSVG.Fill.Color := cSvg;
          FSvg.Svg.OverrideColor := $FFFFFFFF;
        end;
      end;
    except

    end;
  end;
end;

class procedure TAguarde.Hide;
begin
  if Assigned(FLyt) then
  begin
    try

      if Assigned(FMsg) then
        FreeAndNil(FMsg);

      if Assigned(FMsgDescricao) then
        FreeAndNil(FMsgDescricao);

      if Assigned(FAnimacao) then
        FreeAndNil(FAnimacao);

      if Assigned(FArco) then
        FreeAndNil(FArco);                           

      if Assigned(FFundo) then
        FreeAndNil(FFundo);

      if Assigned(FRectSVG) then
        FreeAndNil(FRectSVG);

      if Assigned(FLyt) then
        FreeAndNil(FLyt);

    except

    end;
  end;

  FMsg := nil;
  FMsgDescricao := nil;
  FAnimacao := nil;
  FArco := nil;
  FFundo := nil;
  FRectSVG := nil;
  FSvg := nil;
  FLyt := nil;
end;

class procedure TAguarde.Start(const AFrm: Tform; const AMsgTitulo: string;
                              const AMsgDescricao: string; Amodo: TModo; ACorFundo: Cardinal = $FF333075;
                              ACorFonte: Cardinal = $FFFEFFFF; ACorArco: Cardinal = $FFE400E4;
                              ACorCirculo: Cardinal = $FFFEFFFF);
var
  LService: IFMXVirtualKeyboardService;
begin
  try
    FMsg := nil;
    FMsgDescricao := nil;
    FAnimacao := nil;
    FArco := nil;
    FFundo := nil;
    FRectSVG := nil;
    FSvg := nil;
    FLyt := nil;

    FFundo := TRectangle.Create(AFrm);
    FFundo.BringToFront;
    FFundo.Parent := AFrm;
    FFundo.Opacity := 1;
    FFundo.Visible := true;
    FFundo.Align := TAlignLayout.Client;
    FFundo.Fill.Color := ACorFundo;
    FFundo.Fill.Kind := TBrushKind.Solid;
    FFundo.Stroke.Kind := TBrushKind.None;
    FFundo.Visible := true;

    FLyt := TLayout.Create(AFrm);
    FLyt.Parent := AFrm;
    FLyt.Opacity := 0;
    FLyt.Visible := true;
    FLyt.Align := TAlignLayout.Center;
    FLyt.Width := 1366;
    FLyt.Height := 739;
    FLyt.Visible := true;

    FRectSVG := TRoundRect.Create(AFrm);
    FRectSVG.Parent := FLyt;
    FRectSVG.Opacity := 1;
    FRectSVG.Visible := true;
    FRectSVG.Height := 244;
    FRectSVG.Width := 244;
    FRectSVG.Align := TAlignLayout.Center;
    FRectSVG.Fill.Color := ACorCirculo;
    FRectSVG.Fill.Kind := TBrushKind.Solid;
    FRectSVG.Stroke.Kind := TBrushKind.None;
    FRectSVG.Visible := true;

    FArco := TArc.Create(AFrm);
    FArco.Visible := true;
    FArco.Parent := FRectSVG;
    FArco.Align := TAlignLayout.Center;
    FArco.Width := 270;
    FArco.Height := 270;
    FArco.EndAngle := 270;
    FArco.Stroke.Color := ACorArco;
    FArco.Stroke.Thickness := 13;
    FArco.Position.X := trunc((FLyt.Width - FArco.Width) / 2);
    FArco.Position.Y := 0;

    FAnimacao := TFloatAnimation.Create(AFrm);
    FAnimacao.Parent := FArco;
    FAnimacao.StartValue := 0;
    FAnimacao.StopValue := 360;
    FAnimacao.Duration := 0.8;
    FAnimacao.Loop := true;
    FAnimacao.PropertyName := 'RotationAngle';
    FAnimacao.AnimationType := TAnimationType.InOut;
    FAnimacao.Interpolation := TInterpolationType.Linear;
    FAnimacao.Start;

    FSvg := TSkSvg.Create(AFrm);
    FSvg.Parent := FRectSVG;
    FSvg.Visible := true;
    FSvg.Align := TAlignLayout.Center;
    FSvg.Width := 136;
    FSvg.Height := 136;
    FSvg.Svg.OverrideColor :=cSvg;
    FSvg.Visible := true;

    if Amodo = TModo.Aguarde then
      FSvg.Svg.Source := cCarregando;

    if Amodo = TModo.Finalizado then
      FSvg.Svg.Source := cFinalizado;

    if Amodo = TModo.Dinheiro then
      FSvg.Svg.Source := cDinheiro;

     if Amodo = TModo.Imprimindo then
      FSvg.Svg.Source := cImprimindo;

    FMsg := TSKLabel.Create(AFrm);
    FMsg.Parent := FLyt;
    FMsg.Align := TAlignLayout.MostTop;
    FMsg.Height := 48;
    FMsg.Width := AFrm.Width - 100;
    FMsg.TextSettings.HorzAlign := TSkTextHorzAlign.Center;
    FMsg.TextSettings.Font.Size := 48;
    FMsg.TextSettings.FontColor := ACorFonte;
    FMsg.StyledSettings := [TStyledSetting.Family, TStyledSetting.Style];
    FMsg.Text := AMsgTitulo;
    FMsg.TextSettings.Font.Families :=  'Poppins';

    FMsgDescricao := TSKLabel.Create(AFrm);
    FMsgDescricao.Parent := FLyt;
    FMsgDescricao.Align := TAlignLayout.Top;
    FMsgDescricao.TextSettings.Font.Size := 20;
    FMsgDescricao.Margins.Top := 22;
    FMsgDescricao.Height := 22;
    FMsgDescricao.Width := AFrm.Width - 100;
    FMsgDescricao.TextSettings.FontColor := ACorFonte;
    FMsgDescricao.TextSettings.HorzAlign := TSkTextHorzAlign.Center;
    FMsgDescricao.StyledSettings := [TStyledSetting.Family, TStyledSetting.Style];
    FMsgDescricao.Text := AMsgDescricao;
    FMsgDescricao.TextSettings.Font.Families :=  'Poppins';

    FFundo.AnimateFloat('Opacity', 1);
    FLyt.AnimateFloat('Opacity', 1);
    FLyt.BringToFront;

    TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(LService));
    if (LService <> nil) then
    begin
      LService.HideVirtualKeyboard;
    end;
    LService := nil;

  except on E:Exception do
    exit;
  end;
end;

end.
