From: Pavel Troller <patrol@sinus.cz>
Subject: Re: automount 4.1.3: unmount timeout not working
Date: Sat, 29 Jan 2005 07:01:36 +0100
Message-ID: <20050129060136.GA16475@tangens.sinus.cz>
References: <20050122215228.GA14303@tangens.sinus.cz>
	<Pine.LNX.4.61.0501262240140.1716@donald.themaw.net>
	<20050126194824.GA3627@tangens.sinus.cz>
	<Pine.LNX.4.61.0501291154590.1607@donald.themaw.net>
	<20050129044935.GA11104@tangens.sinus.cz>
	<Pine.LNX.4.61.0501291243130.1607@donald.themaw.net>
Reply-To: Pavel Troller <patrol@sinus.cz>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501291243130.1607@donald.themaw.net>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net
Cc: autofs@linux.kernel.org, Pavel Troller <patrol@sinus.cz>

> What I'm looking for is log entries after the mount happens.
> Where you see the alarm firing and expire checks happening.
> Basically, you don't have any expiration happening (obviously) so the 
> alarm timer must be set to 0. We need to establish why.
> 
> So using the --debug should give you that.
> Include the log from each test please and I'll put together a patch to log 
> some extra stuff.
> 
> I'll go back through you mails to check what version your using.
> 
> Ian
Hi Ian!
  Thanks for Your great care, I hope that we'll fix it soon!
  To save your time:
root@arcus:~# automount --version
Linux automount version 4.1.3
  And my /etc/init.d/autofs already contains
#       The automount options may be added here
#       e.g. amoptions='-t 15'
amoptions='--timeout 3 -d'
  so I think that the debug flag is already on.
                                      With regards, Pavel
