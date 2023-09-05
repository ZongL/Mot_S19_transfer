from Crypto.Hash import CMAC
from Crypto.Cipher import AES

fixdata = bytes.fromhex("00 00 00 05 34 00 00 00 00 2F FD 00")
key = bytes.fromhex("16bytes")

# 读取data.bin的数据
with open("data.binn", "rb") as f:
    bin_data = f.read()

# 计算CMAC值
c = CMAC.new(key, bin_data, ciphermod=AES)
mac = c.digest()

# 填充指定数据
with open("CMAC.binn", "wb") as f:
    f.write(fixdata)

# 写入CMAC值
with open("CMAC.binn", "ab") as f:
    f.write(mac)

# 写入FF值
with open("CMAC.binn", "ab") as f:
    f.write(b'\xFF' * (256 - 28))
    
print("CMAC generation done!")
