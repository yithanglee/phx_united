defmodule United.Encryption do
  # 256 bits
  @key_size 32
  # 128 bits
  @iv_size 16

  def generate_key do
    :crypto.strong_rand_bytes(@key_size) |> Base.encode64()
  end

  def encrypt(string) do
    key = decode_key()
    iv = :crypto.strong_rand_bytes(@iv_size)

    encrypted = :crypto.crypto_one_time(:aes_256_cbc, key, iv, pad(string), true)
    (iv <> encrypted) |> Base.encode64()
  end

  def decrypt(encoded_string) do
    key = decode_key()
    {:ok, bin} = Base.decode64(encoded_string)

    <<iv::binary-@iv_size, encrypted::binary>> = bin
    decrypted = :crypto.crypto_one_time(:aes_256_cbc, key, iv, encrypted, false)
    unpad(decrypted)
  end

  # PKCS7 padding
  defp pad(data) do
    pad_length = 16 - rem(byte_size(data), 16)
    data <> :binary.copy(<<pad_length>>, pad_length)
  end

  defp unpad(data) do
    <<pad_length>> = binary_part(data, byte_size(data), -1)
    binary_part(data, 0, byte_size(data) - pad_length)
  end

  defp decode_key do
    "nPuA1bM+Xc1nMYDmoJ5n6XFalGa+wW/ltxcy7JIC3ss=" |> Base.decode64!()
  end
end
