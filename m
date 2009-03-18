From: "michael@kmaclub.com" <michael@kmaclub.com>
Subject: Re: autofs5 early daemonization side effects
Date: Wed, 18 Mar 2009 07:27:29 -0700
Message-ID: <49C104D1.7060200@kmaclub.com>
References: <c2d0b6ec0903180710s63e5aaa7r567c66d1139dd718@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <c2d0b6ec0903180710s63e5aaa7r567c66d1139dd718@mail.gmail.com>
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
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Cc: autofs@linux.kernel.org

Leonardo Chiquitto wrote:
> Hello,
> 
> I've been doing some tests with AutoFS5 and I'd like to confirm that
> the behavior I'm seeing during the daemon initialization is expected
> or not.
> 
> The problem: when the autofs initscript returns, autofs is not really
> ready.
> 
> Reading the code, I see that the automount daemon detaches itself from
> the controlling terminal (becoming a daemon) early in its initialization.
> After that, it starts other threads to handle different tasks and just then
> reads the available maps. Normally, reading the maps is quick, but it
> could take a bit more if using NIS or LDAP, what explains the delay
> between the initscript returning (immediately after daemonization) and
> autofs being really ready to proceed.
> 
> I was thinking about some options to work around this problem (like deferring
> daemonization), but after a while, I couldn't find a clean and non-intrusive
> solution. Can you help me here?

I too have this issue.

We have been inserting a sleep into the startup script to allow autofs 
to finish reading the maps prior to other scripts executing.  The issue 
with this solution it the amount of sleep is dependedent on the site and 
how many NFS maps/mounts.  For some sites it is 1 second, for others it 
is almost 25.

Without it, many of our startup scripts fails because autofs isn't ready.

It would be nice to have a better solution.

Michael
