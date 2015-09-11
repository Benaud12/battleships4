require 'submarine'

describe Submarine do

  it 'ship does not return dead when hit for the first time' do
    expect{subject.hit}.not_to output("Dead!\n").to_stdout
  end

  it 'tells us when it\'s dead' do
    subject.hit
    expect{subject.hit}.to output("You sunk my battleship!\n").to_stdout
  end

end