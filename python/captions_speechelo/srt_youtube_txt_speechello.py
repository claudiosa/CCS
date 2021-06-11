# this code was created by CCS
## to use  python3 srt_youtube_txt_speechello.py input.txt
## read a file from youtube.str (captions)
## transforms in variable intervals to speechello
## NO WARRANTY

## module base
import pysrt
# https://github.com/byroot/pysrt/blob/master/pysrt/srtitem.py
# https://github.com/byroot/pysrt/blob/master/pysrt/srttime.py


## just to input file
import sys

def to_speechello(input_file):
    all_L = pysrt.open(input_file)
    ## testing
    #all_L = pysrt.open("captions_English.str")
    ## print(len(all_file)) ==> number of elements in this list

    n = len(all_L)    # number of INDEX or entries in str file
    for i in range(n-1):
        #start_current = all_L[i].end 
        end_current = all_L[i].end 
        end_next = all_L[i+1].end
        # start_next = all_L[i+1].start
        interval = (end_next - end_current) - all_L[i].duration
        #print(interval, "   ", all_L[i].duration)
        #interval = (end_current - start_current)
        print(all_L[i].text)   
        ### TAKE CARE here ....
        in_seconds = ((interval.seconds/60 ) + (interval.milliseconds/1000))         #print("Seconds: %.3f Mili: %.4f  " % ((interval.seconds % 60) , (interval.milliseconds/1000), all_L[i].duration ) )
        print("\n[sPause sec=%.2f ePause]" % (in_seconds) ) 
        #print("=> S:%.2f M:%.4f " % (interval.seconds%60 , interval.milliseconds ) ) 

    #print("Finally")
    print(all_L[n-1].text)   # out of this loop, the last entry

def main():
    filename = sys.argv[-1]
    to_speechello(filename)

if __name__ == '__main__':
    main()


'''    
#   print(interval.seconds)
#   print(interval.milliseconds)
        
        #print(all_L[i].duration)
        #print(start_next)
    
    
    #for sub in all_file:
    #print(sub.index)
#    print(sub.start.seconds)
#    print(sub.start)
#    print(sub.end)
#    print(sub.end - sub.start)
#    print(sub.text)
     #print( len(sub) )
     #print(sub.text_without_tags)
     #   print()

## to be improve ... if necessary
        if (interval.seconds > 0.0 ):
            print("\n[sPause sec=%.2f ePause]" % (interval.seconds/60) )
            print(interval.ordinal)

        else:    
            print("\n[sPause sec=%.2f ePause]" % (interval.milliseconds/1000) )
             
'''