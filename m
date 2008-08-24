From: Joe Pruett <joey@clean.q7.com>
Subject: Re: something changed from 4 to 5
Date: Sun, 24 Aug 2008 07:48:29 -0700 (PDT)
Message-ID: <alpine.LRH.1.10.0808240746050.14552@q7.q7.com>
References: <alpine.LRH.1.10.0808120940350.4317@q7.q7.com>
	<1218596289.3148.8.camel@raven.themaw.net>
	<alpine.LRH.1.10.0808230743560.25167@q7.q7.com>
	<48B0E465.80701@themaw.net>
	<alpine.LRH.1.10.0808232150000.7557@q7.q7.com>
	<48B0ED9B.5080103@themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <48B0ED9B.5080103@themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

> And the call to access(2) is seen in the first backtrace as waiting on an nfs 
> mount and any other processes calling to access(2) should wait on the first 
> in this case, since the path includes the same mount.
>
> When this happens you could also try looking for mount processes to match 
> them to those in the backtraces but if any have died that should result in 
> the daemon continuing. So it's a bit puzzling.

i don't think there are any mount processes hanging around.  i'll look the 
next time it happens.

what is the best way to get debugging output?  -l debug?  or -d?  or both?
