From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: "simultaneous" mounts causing weird behavior
Date: Tue, 04 Nov 2003 13:03:30 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FA81422.7070004@zytor.com>
References: <1067956957.2208.13.camel@aluminum> <3FA7DBB3.1020904@zytor.com>
	<1067979370.2630.110.camel@aluminum>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1067979370.2630.110.camel@aluminum>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Matthew Mitchell <matthew@geodev.com>
Cc: autofs@linux.kernel.org

Matthew Mitchell wrote:
> 
> Yes, I know that mount can do that now.  But automount is spawning the
> second mount before the first one completes, no?  Still seems like there
> should be some sort of mutual exclusion around the lookup_mount call.  I
> realize our workload is kind of funny in that the processes effectively
> _try_ to synchronize their automount request.  
> 

autofs 3 relied on the mutural exclusion inherent in mount(2).  When
this was changed, it introduced a race condition in autofs 3.  I have
asked to add a mount flag to override this new behaviour; I don't know
if one was ever introduced or added to mount(8).

> Has any of this changed in the 4.0-pre autofs?  I haven't read through
> its source yet.

autofs 4 uses a different mutural exclusion strategy, so I would *think*
it would not be affected.

	-hpa
