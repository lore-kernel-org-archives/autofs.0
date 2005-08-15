From: Mike Marion <mmarion@qualcomm.com>
Subject: Re: Here's a new really odd auto.net bug
Date: Sun, 14 Aug 2005 23:02:20 -0700 (PDT)
Message-ID: <200508150602.j7F62LNq023532@neophyte.qualcomm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: INLINE
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
To: raven@themaw.net
Cc: autofs@linux.kernel.org

On 10 Aug, Ian Kent wrote:

> OK. I thought you were talking about kernel patches. Sorry.

No, sorry.. daemon patches.

BTW, so far I've only seen one bug in the updated daemon with those patches,
with ghosting and direct maps.  If a mount gets hung, then HUPing the daemons,
even ones not related to the hung path (/net path hung and direct maps on
paths /prj and /iceng) doesn't seem to work.

e.g. had a host where some new paths under /prj added to map weren't taking 
effect.  Numerous hups to daemons didn't help.  Finally noticed an error about 
stating a filesystem in /net.  Was able to force umount that path, and next 
HUPs made new paths now accessible.   

Can recreate and strace daemon(s) sometime this week for more data.

-- 
Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
"...Microsoft has taken a perfectly good standard, broken it, and then told us 
that we have to buy expensive programs that support the broken interface rather
than use the free ones that come with all operating systems in the world except
Microsoft operating systems." 
==> Allen Holub (http://i-want-a-website.com/about-microsoft/quotes.html)
