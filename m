From: raven@themaw.net
Subject: Re: Autofs
Date: Thu, 15 Apr 2004 20:44:20 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0404152040580.15663@donald.themaw.net>
References: <20040415001726.M16653@ftghome.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20040415001726.M16653@ftghome.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dinesh Parmar <dinesh@ftghome.com>
Cc: autofs@linux.kernel.org

On Wed, 14 Apr 2004, Dinesh Parmar wrote:

> Hello,
> 
> Problem: Not able to mount NIS maps from NIS server(Solaris) to Linux(Red Hat 
> 7.3)
> 
> My Network Schema 
> 
> NIS Server: SunOS 5.6 
> NIS Client : Mix of Sunos & HPUX & Linux machine(Red Hat Linux 7.3). 
> 
> Problem: I am trying to mount NIS maps from NIS Server(auto_home & auto_xyz) 
> mounted on Linux. I have configured Linux as NIS client and it is in working 
> condition. 
> 
> Testing of NIS Client: ypcat passwd & ypcat hosts list all the Maps from the 
> server. 

Can you do ypcat -k auto_home and ypcat -k auto_xyz?

> 
> When i try to automount a directory from NIS server it works out fine. 
> 
> Linux machine autofs configuration 
> 
> more /etc/auto.master 
> 
> /usr/dinesh   file:/etc/auto.misc  --timeout=120 
> 
> more /etc/auto.misc 
> 
> linux    -ro,soft,intr    mother:/export/local/sun4u 
> 
> With this configuration i get the automount done for this partition.
> But the requirement is to mount the maps so that any updates are done at one 
> place only and not doing manually on all the linux machines

So what have you used in your master map to attempt to mount from the NIS 
server?

What version of autofs?
What kernel version?

Ian
