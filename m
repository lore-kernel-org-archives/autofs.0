From: Justin Rush <jrush@scout.wisc.edu>
Subject: nfs optimization settings in the automounter
Date: Tue, 18 Nov 2003 11:52:35 -0600
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FBA5C63.9080402@scout.wisc.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

I am having a hard time telling the automounter to use the options 
rsize=32768,wsize=32768 when automounting home directories.  I have 
tried specifying these options in the auto.home file on my nis master 
server ( -rw,soft,rsize=32768,wsize=32768 nismaster:/export/home/jrush )
I have also tried to put them in the localoptions setting in the autofs 
init file ( localoptions='rsize=32768,wsize=32768' ) on both the nis 
master and on the client machines.
I also tried to specify these options in the auto.master file on the nis 
master (the client machines don't have auto.master files because they 
read the nis master's file ) ( /etc/auto.home  
--timeout=43200,rsize=32768,wsize=32768 )
I have also tried to use lower settings such as 16384

however when I look in /proc/mounts on the client machine it is either 
mounted with 4096 or 8192

My setup is as follows:
All the machines are running redhat 9 using Linux automount version 
3.1.7 and nfs version 3

Justin Rush
Technical Specialist
Internet Scout Project
jrush@scout.wisc.edu
