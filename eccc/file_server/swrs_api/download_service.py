from queue import Queue
from threading import Thread
from smart_open import open

class DownloadService:
  def generator(file_path, chunk_size=2048):
    with open(file_path, 'rb') as file_descriptor:
      while 1:
        buf = file_descriptor.read(chunk_size)
        if buf:
          yield buf
        else:
          break

  # Small optimization: threading and async download / read of the chunks
  # Initial local test showed no difference with synchronous method
  # 2048 chunk size seemed optimal
  def threaded_generator(file_path, chunk_size=2048):
    #small queue, we don't want to fill the memory
    chunkQueue = Queue(maxsize=20)
    
    def download_task(file_path, chunkQueue):
      with open(file_path, 'rb') as file_descriptor:
        while 1:
          buf = file_descriptor.read(chunk_size)
          if buf:
            chunkQueue.put((False, buf))
          else:
            chunkQueue.put((True, []))
            break
    
    downloader = Thread(target=download_task, args=(file_path, chunkQueue))
    downloader.setDaemon(True)
    downloader.start()
      
    while 1:
      # Passing finished flag in tuple allows atomic queue/dequeue operation
      (finished, buf) = chunkQueue.get()
      if not finished:
        yield buf
      else:
        break