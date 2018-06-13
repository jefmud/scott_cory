x = 44061035

w= -11.9
t = 27.2

class BinaryRep:
    def __init__(self, value=0, length=32):
        self.value = value
        self.length = length
                
    def binary(self, length=None):
        """return a binary string of a particular length upper pad with zeros"""
        bin_str = "{0:b}".format(self.value)
        if length is None:
            length = self.length
        if len(bin_str) < length:
            # pad the string
            return (length-len(bin_str)) * "0" + bin_str
        else:
            return bin_str
    
    def bits(self, start, end):
        """return the binary value of bits start to end"""
        bs = self.binary()
        return bs[len(bs)-end:len(bs)-start]  
    
    def bits_value(self, start, end):
        sbits = self.bits(start, end)
        return int(sbits,2)
    
    def water_potential(self):
        """water potential (psi)"""
        Rw = self.bits_value(0,16)
        return (10**(0.0001*Rw))/-10.20408
    
    def temperature(self):
        """return temperature, bits 16-26"""
        bs = self.bits(16,26)
        Rt = self.bits_value(16,26)
        if Rt <= 900:
            return (Rt-400)/10.0
        else:
            return ((900+5*(Rt-900))-400)/10.0
        

v = BinaryRep(x)
print(v.binary())

print(v.bits(0,16), '=', v.bits_value(0,16))
print(v.bits(16,26), '=', v.bits_value(16,26))

print(v.water_potential(), v.temperature())
print("compare")
print(-11.9,27.2)



