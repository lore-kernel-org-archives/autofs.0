From: Ian Kent <raven@themaw.net>
Subject: Re: kill automount processes at the same time
Date: Sun, 21 May 2006 11:29:00 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0605211128110.2714@raven.themaw.net>
References: <009d01c67b08$cfa06cf0$6cf1718c@administrator>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <009d01c67b08$cfa06cf0$6cf1718c@administrator>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Latrell <is85022@cis.nctu.edu.tw>
Cc: autofs@linux.kernel.org

On Fri, 19 May 2006, Latrell wrote:

> Hi All:
> 
> I have a problem with kill automount processes. My secenario is as follows:
> 5 automount processes running in my system. When I want to umount and stop automount processes, I used kill pid1 pid2 pid3 pid4 pid5. The result is more than 5 automount processes (8 in the case) in my system! Some automount processes were killed, some automount processes fork processes! Did I do something wrong?
> 
> I looked into the source code, and find the abnormal processes all blocked in 
> a while(ioctl(ap.ioctlfd,AUTOFS_IOC_EXPIRE_MULTI,&how)&&count--) of automount.c and 
> the count didn't decrease.  I also noticed that when I kill less than 3 automount processes at the same time, the problem didn't happen. It seems automount has problem
> dealing with too many kill at the same time. Please give me some advice.

Use the init script to stop autofs.

Ian
