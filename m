From: "Dinesh Parmar" <dinesh@ftghome.com>
Subject: Autofs
Date: Wed, 14 Apr 2004 20:22:59 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20040415001726.M16653@ftghome.com>
Mime-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

Hello,

Problem: Not able to mount NIS maps from NIS server(Solaris) to Linux(Red Hat 
7.3)

My Network Schema 

NIS Server: SunOS 5.6 
NIS Client : Mix of Sunos & HPUX & Linux machine(Red Hat Linux 7.3). 

Problem: I am trying to mount NIS maps from NIS Server(auto_home & auto_xyz) 
mounted on Linux. I have configured Linux as NIS client and it is in working 
condition. 

Testing of NIS Client: ypcat passwd & ypcat hosts list all the Maps from the 
server. 

When i try to automount a directory from NIS server it works out fine. 

Linux machine autofs configuration 

more /etc/auto.master 

/usr/dinesh   file:/etc/auto.misc  --timeout=120 

more /etc/auto.misc 

linux    -ro,soft,intr    mother:/export/local/sun4u 

With this configuration i get the automount done for this partition.
But the requirement is to mount the maps so that any updates are done at one 
place only and not doing manually on all the linux machines

Among Solaris & HPUX client the maps are properly propogated from NIS master 
but on Linux it is not happening. 

I was wondering if you could provide some pointers to solve this problem. 

With Regards 

-Dinesh Parmar 
