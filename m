From: Mike Marion <mmarion@qualcomm.com>
Subject: Re: automount[ ]: failed to mount
Date: Fri, 11 Mar 2005 09:12:53 -0800 (PST)
Message-ID: <200503111712.j2BHCrGK028344@cornholio.qualcomm.com>
Mime-Version: 1.0
Content-Disposition: INLINE
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
To: autofs@linux.kernel.org

On 10 Mar, Sev Binello wrote:

> Yes, trying it already.
> Installed it yesterday.
> No failed mount  messages since.
> Looks goo so far.

Also, make sure you have the autofs4 kernel module loaded and not the older
autofs one.  I'd see similar problems (and especially problems in /net) if I
forgot to add
alias autofs autofs4 
in the modules.conf file and the old module loaded, but I was still running 
the 4.x daemon.

-- 
Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
[Bart & Lisa are reading a magazine at the Kwik-E-Mart.]
Apu: "Hey, hey, this is not a lending library. If you're
not going to buy that thing put it down or I'll blow your heads off!"
-- Simpsons
