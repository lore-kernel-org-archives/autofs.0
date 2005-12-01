From: Farkas Levente <lfarkas@bppiac.hu>
Subject: Re: automount never umount
Date: Thu, 01 Dec 2005 10:31:20 +0100
Message-ID: <438EC2E8.6060602@bppiac.hu>
References: <4381E865.4070908@bppiac.hu>	<Pine.LNX.4.58.0511220822410.16196@wombat.indigo.net.au>	<4382E835.3020904@bppiac.hu>	<Pine.LNX.4.63.0511222054060.2600@donald.themaw.net>	<438344F7.8020503@bppiac.hu>	<17283.19512.49399.338448@segfault.boston.redhat.com>	<43838CA9.40105@bppiac.hu>	<17283.46783.748916.772469@segfault.boston.redhat.com>	<438435EF.6080102@bppiac.hu>	<Pine.LNX.4.63.0511232105320.3200@donald.themaw.net>	<43846C1C.3050305@bppiac.hu>	<17284.35467.301318.255602@segfault.boston.redhat.com>	<Pine.LNX.4.63.0511232334300.3253@donald.themaw.net>	<17284.40834.559604.943290@segfault.boston.redhat.com>	<4384A354.9040502@bppiac.hu>	<17284.41971.660257.356263@segfault.boston.redhat.com>	<43859055.3020508@bppiac.hu>	<Pine.LNX.4.63.0511242003250.2069@donald.themaw.net>	<17291.9542.484484.306141@segfault.boston.redhat.com>
	<438C4983.30504@bppiac.hu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <438C4983.30504@bppiac.hu>
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
Content-Type: text/plain; charset="us-ascii"
To: jmoyer@redhat.com
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

Farkas Levente wrote:
> Jeff Moyer wrote:
>>Sure, you could enable debug.  I just didn't want to get too much
>>information.  However, at this point, it's probably better that we get as
>>much as possible so Farkas doesn't have to keep trying new patches.
>>
>>Farkas, please look at the output of dmesg and let us know what you find.
>>You should see something like this:
> 
> 
> # dmesg |sort|uniq
> 
> autofs4_revalidate: revalidate called on behalf of application "automount"
> autofs4_revalidate: revalidate called on behalf of application
> "multiload-apple"
> 
> so what can i do? no longer use multiload-applet ? this is a standard
> gnome applet included in fc4: "System Monitor 2.10.1"

so what is the conclusion now?
will autofs be modified to umount even in such case or ...?
thnaks.

-- 
  Levente                               "Si vis pacem para bellum!"
