# Tidy Dataset CodeBook
### Submitted as part of the 'Getting & Cleaning Data' MOOC project

# Variables
1. experimentSubject - an INTEGER idetifying the subject number in the experiment. Values [1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30]
2. activityType - a CATEGORICAL (factor) column indicating the type of activity the subject was performing when the measure was taken. Values (levels) ["LAYING" "SITTING" "STANDING" "WALKING" "WALKING_DOWNSTAIRS" "WALKING_UPSTAIRS"]

The following 66 variables follow this convention. 

* Value range: (-inf, +inf). All rational numbers.
* Measurements were taken of the X, Y and Z axes, where specified.
* `_time` suffix means the variable is in the time domain
* `_freq` suffix means it is in the frequency domain after a FFT
* `Body` means the source of the measurement is the body of the subject
* `Gravity` means the source is the gravitational pull against the smartphone
* `Accelerometer` means the measure was taken by the smartphone's accelerometer
* `Gyroscope` means the measure was taken by the smartphone's gyroscope
* `Jerk` is a signal obtained from deriving in time the `Body`'s linear acceleration and angular moment
* `Magnitude` is the scalar accompanying the `Jerk` signal'
* `mean` and `stdev` are means and standard deviations of each measure, respectively

3. time_BodyAccelerometer-mean-X
4. time_BodyAccelerometer-mean-Y               
5. time_BodyAccelerometer-mean-Z                
6. time_BodyAccelerometer-std-X                
7. time_BodyAccelerometer-std-Y                 
8. time_BodyAccelerometer-std-Z                
9. time_GravityAccelerometer-mean-X             
10. time_GravityAccelerometer-mean-Y            
11. time_GravityAccelerometer-mean-Z             
12. time_GravityAccelerometer-std-X             
13. time_GravityAccelerometer-std-Y              
14. time_GravityAccelerometer-std-Z             
15. time_BodyAccelerometerJerk-mean-X            
16. time_BodyAccelerometerJerk-mean-Y           
17. time_BodyAccelerometerJerk-mean-Z            
18. time_BodyAccelerometerJerk-std-X            
19. time_BodyAccelerometerJerk-std-Y             
20. time_BodyAccelerometerJerk-std-Z            
21. time_BodyGyroscope-mean-X                    
22. time_BodyGyroscope-mean-Y                   
23. time_BodyGyroscope-mean-Z                    
24. time_BodyGyroscope-std-X                    
25. time_BodyGyroscope-std-Y                     
26. time_BodyGyroscope-std-Z                    
27. time_BodyGyroscopeJerk-mean-X                
28. time_BodyGyroscopeJerk-mean-Y               
29. time_BodyGyroscopeJerk-mean-Z                
30. time_BodyGyroscopeJerk-std-X                
31. time_BodyGyroscopeJerk-std-Y                 
32. time_BodyGyroscopeJerk-std-Z                
33. time_BodyAccelerometerMagnitude-mean         
34. time_BodyAccelerometerMagnitude-std         
35. time_GravityAccelerometerMagnitude-mean      
36. time_GravityAccelerometerMagnitude-std      
37. time_BodyAccelerometerJerkMagnitude-mean     
38. time_BodyAccelerometerJerkMagnitude-std     
39. time_BodyGyroscopeMagnitude-mean             
40. time_BodyGyroscopeMagnitude-std             
41. time_BodyGyroscopeJerkMagnitude-mean         
42. time_BodyGyroscopeJerkMagnitude-std         
43. freq_BodyAccelerometer-mean-X                
44. freq_BodyAccelerometer-mean-Y               
45. freq_BodyAccelerometer-mean-Z                
46. freq_BodyAccelerometer-std-X                
47. freq_BodyAccelerometer-std-Y                 
48. freq_BodyAccelerometer-std-Z                
49. freq_BodyAccelerometerJerk-mean-X            
50. freq_BodyAccelerometerJerk-mean-Y           
51. freq_BodyAccelerometerJerk-mean-Z            
52. freq_BodyAccelerometerJerk-std-X            
53. freq_BodyAccelerometerJerk-std-Y             
54. freq_BodyAccelerometerJerk-std-Z            
55. freq_BodyGyroscope-mean-X                    
56. freq_BodyGyroscope-mean-Y                   
57. freq_BodyGyroscope-mean-Z                    
58. freq_BodyGyroscope-std-X                    
59. freq_BodyGyroscope-std-Y                     
60. freq_BodyGyroscope-std-Z                    
61. freq_BodyAccelerometerMagnitude-mean         
62. freq_BodyAccelerometerMagnitude-std         
63. freq_BodyBodyAccelerometerJerkMagnitude-mean 
64. freq_BodyBodyAccelerometerJerkMagnitude-std 
65. freq_BodyBodyGyroscopeMagnitude-mean         
66. freq_BodyBodyGyroscopeMagnitude-std         
67. freq_BodyBodyGyroscopeJerkMagnitude-mean     
68. freq_BodyBodyGyroscopeJerkMagnitude-std

## How to obtain this tidy dataset
Run the `run_analysis.R` script. It will automatically download the files and take the steps necessary to produce this tidy dataset.