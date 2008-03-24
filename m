From: "Paul B. Henson" <henson@acm.org>
Subject: Re: sudo and autofs
Date: Mon, 24 Mar 2008 13:52:36 -0800 (PST)
Message-ID: <Pine.GSO.4.55.0803241350360.14855@loogie.intranet.csupomona.edu>
References: <1203828797.5413.355.camel@localhost> <47E391D4.9050107@inria.fr>
	<Pine.LNX.4.64.0803210832590.3306@simba.math.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0803210832590.3306@simba.math.ucla.edu>
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

On Fri, 21 Mar 2008, Jim Carter wrote:

> Unfortunately Kerberos is used to authenticate the client *host*, so
> hostbased impersonation schemes (rogue laptops) no longer work, but it
> still relies on the client to honestly report the alphabetic loginID and
> group ID of the client user, and so is vulnerable to a generic root
> exploit on the client.

I don't believe that to be the case -- Kerberos NFS authenticates the
end-users. If you're actually using Kerberos security, any access from a
local user without appropriate credentials is mapped to the nobody account
(or simply denied, I don't recall which)


-- 
Paul B. Henson  |  (909) 979-6361  |  http://www.csupomona.edu/~henson/
Operating Systems and Network Analyst  |  henson@csupomona.edu
California State Polytechnic University  |  Pomona CA 91768
