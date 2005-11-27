From: Ian Kent <raven@themaw.net>
Subject: Re: auto.net gets a key with a path under SLES9.
Date: Sun, 27 Nov 2005 21:40:12 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0511272135350.2462@donald.themaw.net>
References: <4378ED9A.6090903@deragon.biz> <43877F6F.5000708@deragon.biz>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <43877F6F.5000708@deragon.biz>
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
To: Hans Deragon <hans@deragon.biz>
Cc: autofs@linux.kernel.org

On Fri, 25 Nov 2005, Hans Deragon wrote:

> Greetings.
> 
> 
>   Well, I successfully reproduced the problem of a path sent to auto.net (see
> below for full description).  Attached, the debug output on syslogd.  From
> what I understand of the syslogd logs, the problem occurs before sun_mount()
> is called.
> 
>   What I did was:
> 
>   cd /net/asterix  # Everything is ok.  $key=asterix
>   cd asteris-07    # Bug:  $key=asterix/asterix-07

Yes. Undoubtably the problem and that will be in the kernel module.

> 
>   What was passed to auto.net was asterix/asterix-07 at the second 'cd'.

I would like to see the output of auto.net run manually and with the 
incorrect key please.

Do you have access to the source for for the kernel you are using so that 
we may check the patch levels?

Ian
