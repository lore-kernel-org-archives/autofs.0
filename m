From: Steve Thompson <smt@vgersoft.com>
Subject: Re: Wrong network
Date: Wed, 16 Feb 2011 17:00:23 -0500 (EST)
Message-ID: <alpine.LRH.0.9999.1102161657250.24619@helios.vgersoft.com>
References: <alpine.LRH.0.9999.1102120924290.6851@helios.vgersoft.com>
	<alpine.LRH.0.9999.1102121518420.12882@helios.vgersoft.com>
	<1297649183.2822.6.camel@perseus>
	<alpine.LRH.0.9999.1102141420430.25310@firefly.vgersoft.com>
	<1297739162.13007.7.camel@perseus>
	<alpine.LRH.0.9999.1102150702520.15610@helios.vgersoft.com>
	<1297772151.13007.21.camel@perseus>
	<alpine.LRH.0.9999.1102150729250.16053@helios.vgersoft.com>
	<1297774988.13007.43.camel@perseus>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1297774988.13007.43.camel@perseus>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Tue, 15 Feb 2011, Ian Kent wrote:

> As far as the hang you have seen, I don't know why that's happening, the
> patches were added between el5_5.4 and el5_5.6 have been around for
> quite a while, upstream and in Fedora and tested by more than one
> customer, so I didn't expect to hear of a problem.

While thinking about this I noticed that the automount hangs all occurred 
on systems that had SElinux set to enforcing mode; there were no hangs on 
systems with SElinux either disabled or in permissive mode. So for now I 
have disabled SElinux on most of the systems on which a hang was observed. 
So far, so good: no more hangs. But it's only been a couple of days, so I 
will keep an eye on it.

Steve
