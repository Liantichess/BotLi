FROM ubuntu:jammy
COPY . .

RUN apt-get update && apt-get upgrade -y && apt-get install -y wget unzip python3 python3-pip git
RUN python3 -m pip install --no-cache-dir -r requirements.txt

# Stockfish - Depending on your CPU it may be necessary to pick a binary other than bmi2
RUN wget https://abrok.eu/stockfish/latest/linux/stockfish_x64_bmi2.zip -O stockfish.zip
RUN unzip stockfish.zip && rm stockfish.zip
RUN mv stockfish_* engines/stockfish && chmod +x engines/stockfish

# Fairy-Stockfish - Depending on your CPU it may be necessary to pick a binary other than bmi2
# To use Fairy-Stockfish, uncomment the following lines and adjust config.yml.default accordingly
RUN wget https://github.com/fairy-stockfish/Fairy-Stockfish/releases/download/fairy_sf_14/fairy-stockfish-largeboard_x86-64-bmi2
RUN mv fairy-stockfish-largeboard_x86-64-bmi2 engines/fairy-stockfish && chmod +x engines/fairy-stockfish
RUN wget "https://drive.google.com/u/0/uc?id=1r5o5jboZRqND8picxuAbA0VXXMJM1HuS&export=download" -O engines/3check-313cc226a173.nnue
RUN wget "https://drive.google.com/u/0/uc?id=1bA80NjyzJugOuKXy5eazTYXzsjeSqKaH&export=download" -O engines/antichess-689c016df8e0.nnue
RUN wget "https://www.patreon.com/file?h=50154821&i=7841375" -O engines/atomic-2cf13ff256cc.nnue
RUN wget "https://www.patreon.com/file?h=57240317&i=9073157" -O engines/crazyhouse-8ebf84784ad2.nnue
RUN wget "https://www.patreon.com/file?h=57472489&i=9116028" -O engines/horde-28173ddccabe.nnue
RUN wget "https://www.patreon.com/file?h=50986381&i=7986110" -O engines/kingofthehill-978b86d0e6a4.nnue
RUN wget "https://www.patreon.com/file?h=56933181&i=9019834" -O engines/racingkings-636b95f085e3.nnue
RUN wget "https://tests.stockfishchess.org/api/nn/nn-4ffa203f3b58.nnue" -O engines/nn-4ffa203f3b58.nnue

# Add the "--matchmaking" flag to start the matchmaking mode.
CMD python3 user_interface.py --matchmaking
