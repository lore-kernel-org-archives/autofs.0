From: Greg Bradner <gregb@rhythm.com>
Subject: Re: backfstype patch.
Date: Wed, 02 Mar 2005 13:03:20 -0800
Message-ID: <42262A18.6040203@rhythm.com>
References: <40F82248.2050803@deragon.biz>
	<16632.9711.453411.560590@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <16632.9711.453411.560590@segfault.boston.redhat.com>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

I am thinking about using cachefs on suse 9.2 and was wondering the 
status of the cachefs mount module?
I'm currently running autofs-4.1.3 with 2.6.10 kernel.

Jeff Moyer wrote:

>==> Regarding [autofs] backfstype patch.; Hans Deragon <hans@deragon.biz> adds:
>
>hans> Greetings.  Remember me with my backfstype patch?  Some people
>hans> commented on it, I replied and then never got any answers since.
>hans> Altough functional, my patch was questionned; the fix was not at the
>hans> right place within the code (from a design/elegance point of view;
>hans> technically it works great).  As I explained, I have no knowledge of
>hans> the overall architecture of Autofs and unfortunatly, I do not have
>hans> the time to get deep into it.
>
>hans>    Can my patch still be applied in the main branch until it is moved
>hans> into a more appropriate area of the code?  Its still adds the new
>hans> backsftype support, does not cause any problems, is very localized,
>hans> and very usefull.  I have been running it since the last 2 weeks
>hans> without any problems.  I am rolling it out in the production
>hans> environment.
>
>Ultimately, this is up to Ian.  I have a todo list item to implement a
>cachefs mount module (which was the agreed upon correct approach).
>Unfortunately, it's quite low on the todo list.  :(
>
>-Jeff
>
>_______________________________________________
>autofs mailing list
>autofs@linux.kernel.org
>http://linux.kernel.org/mailman/listinfo/autofs
>  
>

-- 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Rhythm & Hues
5404 Jandy Place
Los Angeles, CA 90066
Voice: 310 448-7763
Fax:   310 448-7600
gregb@rhythm.com
