From: Thomas Jahns <Thomas.Jahns@gmx.net>
Subject: Re: Limit on return string from program map
Date: Fri, 17 Dec 2004 15:40:08 +0000
Message-ID: <1103298008l.6599l.1l@mercury>
References: <21502.1103178424@kao2.melbourne.sgi.com>
	<Pine.LNX.4.58.0412171422280.22350@wombat.indigo.net.au>
	<16834.63746.614567.523947@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16834.63746.614567.523947@segfault.boston.redhat.com> (from
	jmoyer@redhat.com on Fri Dec 17 16:19:30 2004)
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"; delsp="Yes"; format="Flowed"
To: autofs@linux.kernel.org

On 12/17/04 16:19:30, Jeff Moyer wrote:
>>> the string that automount expects from a program map.  My virtual
>>> CD server has lots of CD images mounted over loopback, each with  
>>> its own export entry, so the return string from auto.net is quite  
>>> long.
> 
> raven> The buffer size for map entries is 4096.

not sure it's related: wasn't there also a very small limit on the  
number of loop-devices?

Thomas Jahns
-- 
"Computers are good at following instructions,
 but not at reading your mind."
D. E. Knuth, The TeXbook, Addison-Wesley 1984, 1986, 1996, p. 9
