import pygame
class piece():
    def __init__(self, type:str, coordinates:list, pos:pygame.rect, image:str):
        self.type = type
        self.coordinates = coordinates
        self.pos = pos
        self.image = pygame.image.load(image)
        self.image = pygame.transform.smoothscale(self.image, (60,60))
        
        
    
    def move(self, alpha, num):
        key = ["A","B","C","D","E","F","G","H"]
        alpha = alpha.upper()
        self.coordinates = [alpha, num]
        num_key = [7,6,5,4,3,2,1,0]
        self.pos = (7.5+key.index(alpha) * 75), 27.5+((num_key.index(int(num)-1)*75))
