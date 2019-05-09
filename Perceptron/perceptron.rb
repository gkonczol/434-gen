class Perceptron
  
  LEARNING_RATE = 0.01
  BIAS = 0.05
  
  attr_accessor :weights
  
  def initialize(number_of_inputs)
    @weights = Array.new(number_of_inputs) {rand(-1.0,1.0)}
    
  end
  
  def output(inputs)
    sum = 0
    inputs.each_with_index do |input|
      sum += input * weights[i]
    end
    sum += BIAS
    activate(sum)
  end
  
  def activate(sum)
    sum > 0 ? 1 : -1
  end
  
  def train(inputs, target_output)
    guess = output(inputs)
    error = target_output - guess
    self.weights = weights.map_with_index do |w, i|
      w + LEARNING_RATE * error * inputs[i]
    end
  end
  
end