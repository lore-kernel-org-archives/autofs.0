From: Mike Marion <mmarion@qualcomm.com>
Subject: Re: unacceptable bug in autofs kernel module
Date: Mon, 7 Mar 2005 11:49:09 -0800
Message-ID: <13d4539f0ea6367322865103397ca277@qualcomm.com>
References: <C147DE5CF1A13D42B560879D6D212E63D0948E@us-bv-m21.global.tektronix.net>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Transfer-Encoding: 7bit
In-Reply-To: <C147DE5CF1A13D42B560879D6D212E63D0948E@us-bv-m21.global.tektronix.net>
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
To: peter.a.harris@exgate.tek.com
Cc: autofs@linux.kernel.org

On Feb 4, 2005, at 10:58 AM, peter.a.harris@exgate.tek.com wrote:

> Funny you should mention - I was just getting ready to ask about this.

Curious.. those that are seeing that mount problem, especially for jobs 
submitted via a system like lsf.. What kind of map(s) are you seeing 
the problems on?  Direct map with/without ghosting?   Program map?  yp? 
ldap? etc..

We've been having the problem with a shell scripted, program map to 
support our sun auto.direct map, but I did just get the newer direct 
map support with ghosting working on a couple test boxes and want to do 
some testing to see if that helps vs the non-visible way it was with 
the program script.

-- 
Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
Drew: "Violence doesn't solve anything? World War I. World War II. Star 
Wars.
every Super Bowl. Who says violence doesn't solve anything?!" ==> Drew 
Cary Show
