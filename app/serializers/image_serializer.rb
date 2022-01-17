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
              source_url: image.source_url,
              photographer: image.photographer,
              photographer_link: image.photographer_link
             }
           }
         }
       }
     }
  end
end