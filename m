From: Ian Kent <raven@themaw.net>
Subject: Re: Is autofs4 8-bit compatible?
Date: Tue, 15 Mar 2005 14:15:54 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0503151412260.30398@wombat.indigo.net.au>
References: <4236723C.000001.02367@mfront8.yandex.ru>
Mime-Version: 1.0
In-Reply-To: <4236723C.000001.02367@mfront8.yandex.ru>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: atlantos41 <atlantos41@yandex.ru>
Cc: autofs@linux.kernel.org

On Tue, 15 Mar 2005, atlantos41 wrote:

> On Thursday 10 March 2005 10:51, Ian Kent wrote:
> >
> > OK. I'll look a bit further.
> >
> > You did mention that autofs 3.1.7 did not have this problem correct?
> > Did you ever try autofs 4.0.0?
> >
> 
> Yes, with autofs 3.1.7 I didn't have this problem. I tried autofs 4.0.0 and it's also have no such problem. The problem arise with autofs 4.1.3, 4.1.4_beta1 and 4.1.4_beta2.
> 
> > Would you be willing to use the "--debug" option on one of your master map
> > entries and send me the log?
> >
> > Ian
> 
> OK. My /etc/auto.smb is
> test_data<cyrchar>est -fstype=smbfs ://test/data<cyrchar>est    
> 
> I start automount with command:
> automount --timeout=60 --verbose --debug /smb file /etc/auto.smb

OK. Only one of --verbose or --debug is needed.

> And have the following entries in syslog:
> 
> Mar 14 16:30:15 localhost automount[11384]: using kernel protocol version 4.05
> Mar 14 16:30:15 localhost automount[11384]: using timeout 60 seconds; freq 15 
> secs
> Mar 14 16:30:38 localhost automount[11384]: attempting to mount entry 
> /smb/test_data
> Mar 14 16:30:38 localhost automount[11395]: failed to mount 
> /smb/test_data
> Mar 14 16:30:38 localhost automount[11395]: umount_multi: no mounts found 
> under /smb/test_data

This is not nearly as much info as you should see.
In particular what I'm actually after (the parsing debug output) is not 
there.

Can you check to see if you are sending debug output to syslog please?

I remember I had to alter my syslog.conf on FC2 at one point.

Ian
