
class MockBlob:
  def __init__(self, 
               name='a', 
               size=1024*1024, # 1MB
               time_created="Thu, 21 Jan 1999 00:00:00 GMT"):
    self.name = name
    self.size = size
    self.time_created = time_created
