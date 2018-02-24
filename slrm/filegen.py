import os,sys,time,subprocess




for j in range(0,31):
    for i in range(0,31):
        epsilon = 0.02+float(i)/30*(0.2-0.02)
        delta = float(j)/30*(10)
        readFile = open("gflow2dtemplate.slurm")
        lines = readFile.readlines()
        lines = lines[:-1]
        lines.append("use-student-matlab -r \"gflow2d("+str(delta)+","+str(epsilon)+",100,50,0.03,seedgen(100,'trig',1,1),'')\"\n")
        readFile.close()
        w = open("gflow2dtemplate.slurm",'w')
        w.writelines([item for item in lines])
        w.close()
        os.system("sbatch gflow2dtemplate.slurm")
        n = 6;
        while n == 6:
            output = subprocess.Popen('squeue -u kingda16',stdout=subprocess.PIPE,shell=True).communicate()[0]
            n = len(output.split('\n'))-1
            time.sleep(60)
            print(i,j)





    
