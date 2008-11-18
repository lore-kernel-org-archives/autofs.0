From: Joe Pruett <joey@clean.q7.com>
Subject: Re: hung server again
Date: Tue, 18 Nov 2008 10:31:34 -0800 (PST)
Message-ID: <alpine.LRH.2.00.0811181028520.18255@q7.q7.com>
References: <alpine.LRH.2.00.0811180725001.21620@q7.q7.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <alpine.LRH.2.00.0811180725001.21620@q7.q7.com>
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
To: autofs@linux.kernel.org

> i did some testing with a single level /home and if i touch all entries in 
> /home, i eventually ran into some resource limits.  maybe there is some 
> tuning i can do?  i could go back to /home just being full of symlinks, but 
> that has so many issues of it's own. i'm looking for feedback of other users 
> that might have servers with a thousand or more active mounts and how that 
> works for you.  or some other good ideas of how people handle this kind of 
> thing.

it looks like centos 4 (2.6.9 based) uses one tcp connection per mount, 
but centos 5 (2.6.19) uses one tcp connection per server.  without delving 
into the kernel source, i haven't come up with any answers from google 
yet.  can anyone on this list speak to this issue?
