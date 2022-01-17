class ImageSerializer
  def self.image(image)
    {
      data: {
        type: 'image',
        id: nil,
        attributes: {
          image: {
            location: image.location,
            image_url: image.url,
            credit: {
              source: image.source,
              photographer: image.photographer,
              photographer_link: image.photographer_link
             }
           }
         }
       }
     }
  end
end