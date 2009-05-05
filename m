From: Martin Tessun <martin.tessun@gmx.de>
Subject: Re: how to use keys ...
Date: Tue, 05 May 2009 21:29:18 +0200
Message-ID: <4A00938E.6050804@gmx.de>
References: <1241234851.12172.5.camel@bellerophon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1241234851.12172.5.camel@bellerophon>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: raespi@estudiantes.uci.cu
Cc: autofs@linux.kernel.org

raespi schrieb:
> Hi, i've been trying out the autofs mounter to gain more availability in
> my network environment ... I have a number of users created already
> under :
> 
> /home/.....
> 
> /home/teratux  :: For example
> 
> I want to be able to automount a resource from NFS in this exact
> location.  This is my auto.master:
> 
> /home   /etc/auto.home --timeout=10
> 
> This is my auto.home:
> 
> x          -ro,soft,intr,rsize=32768,wsize=32768,noatime
> 10.7.22.178:/home

So the auto.master i scorrect. If you want to use wildcards, you can do
so by using the following auto.home:

*	-ro,soft,intr,rsize=32768,wsize=32768,noatime 10.7.22.178:/home/&

So if you do a cd /home/abc it tries to mount 10.7.22.178:/home/abc at
this location.

Regards,
Martin
