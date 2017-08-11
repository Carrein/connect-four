require "connect_four"

describe ConnectFour do
    let(:new_game) {ConnectFour.new}

    describe "#error" do
        context "given an input" do
            it "is between 0 to 6" do
                expect(new_game.error("2")).to eql true
            end

            it "is not between 0 to 6" do
                expect(new_game.error("8")).to eql false
            end

            it "is alphanumerical" do
                expect(new_game.error("a")).to eql false
            end 

            it "contains non-numerical characters" do
                expect(new_game.error("!")).to eql false
            end 

            it "is a sentence" do
                expect(new_game.error("i can't help but wait")).to eql false
            end
        end
    end

    describe "#wincon" do
        context "when there are 3 horizontal consecutive pieces in place" do
            it "@won is set to false" do
                new_game.board[0][0] = " ▦ "
                new_game.board[0][1] = " ▦ "
                new_game.board[0][2] = " ▦ "
                expect(new_game.won).to eql false
            end
        end
        context "when there are 3 vertical consecutive pieces in place" do
            it "@won is set to false" do
                new_game.board[0][0] = " ▦ "
                new_game.board[1][0] = " ▦ "
                new_game.board[2][0] = " ▦ "
                expect(new_game.won).to eql false
            end
        end
        context "when there are 3 diagonal (left to right) consecutive pieces in place" do
            it "@won is set to false" do
                new_game.board[1][1] = " ▦ "
                new_game.board[2][2] = " ▦ "
                new_game.board[3][3] = " ▦ "
                expect(new_game.won).to eql false
            end
        end
        context "when there are 3 diagonal (right to left) consecutive pieces in place" do
            it "@won is set to false" do
                new_game.board[0][3] = " ▦ "
                new_game.board[1][2] = " ▦ "
                new_game.board[2][1] = " ▦ "
                expect(new_game.won).to eql false
            end
        end

        
        context "when there are 4 horizontal consecutive pieces in place" do
            it "@won is set to true" do
                new_game.board[0][2] = " ▦ "
                new_game.board[0][3] = " ▦ "
                new_game.board[0][4] = " ▦ "
                new_game.board[0][5] = " ▦ "
                expect(new_game.wincon).to eql true
            end
        end
        context "when there are 4 vertical consecutive pieces in place" do
            it "@won is set to true" do
                new_game.board[5][0] = " ▦ "
                new_game.board[4][0] = " ▦ "
                new_game.board[3][0] = " ▦ "
                new_game.board[2][0] = " ▦ "
                expect(new_game.wincon).to eql true
            end
        end
        context "when there are 4 diagonal (left to right) consecutive pieces in place" do
            it "@won is set to true" do
                new_game.board[4][3] = " ▦ "
                new_game.board[3][2] = " ▦ "
                new_game.board[2][1] = " ▦ "
                new_game.board[1][0] = " ▦ "
                expect(new_game.wincon).to eql true
            end
        end
        context "when there are 4 diagonal (right to left) consecutive pieces in place" do
            it "@won is set to true" do
                new_game.board[3][0] = " ▦ "
                new_game.board[2][1] = " ▦ "
                new_game.board[1][2] = " ▦ "
                new_game.board[0][3] = " ▦ "
                expect(new_game.wincon).to eql true
            end
        end


        context "test edge cases" do
            it "@won is set to true if diagonal is at bottom left corner" do
                new_game.board[5][0] = " ▦ "
                new_game.board[4][1] = " ▦ "
                new_game.board[3][2] = " ▦ "
                new_game.board[2][3] = " ▦ "
                expect(new_game.wincon).to eql true
            end
            it "@won is set to true if diagonal is at bottom right corner" do
                new_game.board[5][6] = " ▦ "
                new_game.board[4][5] = " ▦ "
                new_game.board[3][4] = " ▦ "
                new_game.board[2][3] = " ▦ "
                expect(new_game.wincon).to eql true
            end
            it "@won is set to true if diagonal is at top left corner" do
                new_game.board[0][0] = " ▦ "
                new_game.board[1][1] = " ▦ "
                new_game.board[2][2] = " ▦ "
                new_game.board[3][3] = " ▦ "
                expect(new_game.wincon).to eql true
            end
            it "@won is set to true if diagonal is at top right corner" do
                new_game.board[0][6] = " ▦ "
                new_game.board[1][5] = " ▦ "
                new_game.board[2][4] = " ▦ "
                new_game.board[3][3] = " ▦ "
                expect(new_game.wincon).to eql true
            end
            it "@won is set to true for a connect four set if a different player piece is used" do
                new_game.board[2][6] = " ◍ "
                new_game.board[4][4] = " ◍ "
                new_game.board[3][5] = " ◍ "
                new_game.board[5][3] = " ◍ "
                expect(new_game.wincon).to eql true
            end
            it "@won is set to true even if pieces are not sloted consecutively." do
                new_game.board[1][2] = " ◍ "
                new_game.board[3][4] = " ◍ "
                new_game.board[4][5] = " ◍ "
                new_game.board[2][3] = " ◍ "
                expect(new_game.wincon).to eql true
            end
        end
    end
end