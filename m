From: "Daniel Richard G." <skunk@iskunk.org>
Subject: Re: Code cleanup
Date: Fri, 28 Jul 2006 10:50:37 -0400
Message-ID: <20060728145037.GS19452@mail.iSKUNK.ORG>
References: <20060714035857.GM29064@mail.iSKUNK.ORG>
	<1154078748.3094.7.camel@gimli.at.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <1154078748.3094.7.camel@gimli.at.home>
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

On Fri, 2006 Jul 28 11:25:48 +0200, Bernd Petrovitsch wrote:
> On Thu, 2006-07-13 at 23:58 -0400, Daniel Richard G. wrote:
> > 
> > * Don't use "#if WITH_FOO", as this produces a warning if WITH_FOO is 
> >   undefined. Use "#ifdef".
> 
> Personally I would define them to always have a value (be it "0" or "1"
> for "false" and "true") - and set them correctly in a .h file or
> Makefile - so you catch typos using them.

There are tradeoffs with the two approaches. I believe autoconf settled on 
#define/#undef/#ifdef to allow easy re-use of source files in different 
environments/contexts, as you don't have to #define all the macros that a 
source file uses to get a clean build. (The ubiquitous "#ifdef 
HAVE_CONFIG_H" clause also serves the same end.)


--Daniel


-- 
NAME   = Daniel Richard G.       ##  Remember, skunks       _\|/_  meef?
EMAIL1 = skunk@iskunk.org        ##  don't smell bad---    (/o|o\) /
EMAIL2 = skunk@alum.mit.edu      ##  it's the people who   < (^),>
WWW    = http://www.******.org/  ##  annoy them that do!    /   \
--
(****** = site not yet online)
