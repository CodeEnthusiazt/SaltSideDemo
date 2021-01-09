platform :ios, '11.0'

def myPods
   pod 'SDWebImage', '~> 5.9.4'
   pod 'Alamofire', '~> 5.4.0'
end
 

target 'SaltSideDemo' do
  use_frameworks!

  myPods

  target 'SaltSideDemoTests' do
     myPods
  end

  target 'SaltSideDemoUITests' do
      myPods
  end

end
