#/bin/bash -v
git clone --depth 1 ssh://gitea@git.ggeta.com:2002/guangzong/stm32-data-generated.git build -q
rm -rf ./build/data
rm -rf ./build/stm32-metapac
./d download-all
cargo run --release --bin stm32-data-gen
cargo run --release --bin stm32-metapac-gen
export COMMIT_HASH=$(git rev-parse HEAD)
cd build/
git add data stm32-metapac
git -c user.name='Guangzong Chen - CI' -c user.email='chen@ggeta.com' commit -m "Generated from stm32-data $COMMIT_HASH"
git -c user.name='Guangzong Chen - CI' -c user.email='chen@ggeta.com' tag - a stm32-data-$COMMIT -m "Generated from stm32-data $COMMIT_HASH"
git push --follow-tags
