
##################################### EMOJI #############################

## emoji array
emojis=(๐ค ๐พ ๐คฎ ๐ค ๐คก ๐ฉ ๐ฝ ๐ฅณ ๐คฉ ๐คฃ ๐ค ๐ ๐ ๐ง ๐น ๐ถ ๐ฅ ๐ฟ ๐ธ  ๐คน  ๐ถ ๐น ๐ฐ ๐ฆ ๐ป ๐ผ ๐จ ๐ฏ ๐ฆ
๐ท ๐ธ ๐ ๐ง ๐ ๐ฆ ๐ฆญ     ๐ฆ ๐ป  ๐ฆฆ ๐ฆฅ ๐ฆฉ ๐ ๐ฌ ๐ก ๐ ๐ฑ ๐ฆ ๐ฆ ๐ฆ ๐ ๐ฃ ๐ฆ ๐ฆฌ    ๐ฆจ ๐ ๐ฆค    ๐ ๐ฆซ    ๐ ๐ฆ ๐ ๐ชฐ    ๐ ๐ฆ ๐ ๐ข ๐ ๐ฆง ๐ฆ ๐ฆฃ   ๐   ๐ฅ ๐ฅฆ ๐ ๐ฅ ๐ ๐ฃ)

emoji() {
  grabEmoji=${emojis[$RANDOM % ${#emojis[@]}]};
  echo $grabEmoji;
}
