From: mmarion@qualcomm.com
Subject: Re: autofs reload
Date: Fri, 26 Mar 2004 16:53:30 -0800 (PST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200403270053.i2R0rUt3013696@miguelito.qualcomm.com>
References: <40646141.2040809@sun.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <40646141.2040809@sun.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

On 26 Mar, Mike Waychison wrote:

> In 4.1.0 you can send a HUP signal to the daemon process controling the
> map to ask it to update the map in similar fashion to running automount
> on Solaris."

BTW, doing that with 4.0.0 (is anyone still running it?) it'll just kill the
daemon.  Found that out the hard way. :-/

I actually wrote a script that runs out of cron every 15 minutes to look for
changes in our auto.home nis map, and only HUP's the daemon if there's a
change, and if the daemon is version >= 4.1.0.  I figure I'd rather not keep
HUP'ing the daemon when there aren't any changes anyway.

-- 
Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
Bob: "Ok, I'm goin'... but a swift kick in the ass isn't the solution to
everything you know."
Red: "I gotta disagree with you there Bob!" -- That 70's show
