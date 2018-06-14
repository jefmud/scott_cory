# for Scott Cory
# R functions to compute temperature and water potential
# from the ECH20 system

bitsToInt <- function(vector) {
  powerOfTwo <- 0
  bsum <- 0
	for (bit in vector) {
	  if (bit == 01) {
	    bsum <- bsum + (2 ** powerOfTwo)
	  }
		powerOfTwo <- powerOfTwo + 1
	}
  return(bsum)
}

bitValue <- function(x, start, end) {
  # takes a number and returns decimal value of bits from start to end
  binary_vector <- intToBits(x)[start:end]
  powerOfTwo <- 0
  bsum <- 0
  for (bit in binary_vector) {
    if (bit == 01) {
      bsum <- bsum + (2 ** powerOfTwo)
    }
    powerOfTwo <- powerOfTwo + 1
  }
  return(bsum)
}

waterPotential <- function(x) {
  # computer water potential (psi)
  # from ECH2O System Specifications and Conversion Equations
  # x is a 32 bit number, bits 1-16 contain Rw (Raw water potential)
  Rw <- bitValue(x,1,16)
  return((10**(0.0001*Rw))/-10.20408)
}

temperature <- function(x) {
  # computer temerature in degrees C
  # from ECH2O System Specifications and Conversion Equations
  # x is a 32 bit number, bits 17-26 contain Rt (Raw temerature reading)
  Rt <- bitValue(x,17,26)
  if (Rt <= 900) {
    return((Rt-400)/10.0)
  } else {
    return(((900+5*(Rt-900))-400)/10.0)
  }
}


x <- 44061035

print(waterPotential(x))
print(temperature(x))
