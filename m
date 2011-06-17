From: Jimmy Dorff <jdorff@phy.duke.edu>
Subject: Re: nesting automount maps in ldap
Date: Fri, 17 Jun 2011 16:40:49 -0400
Message-ID: <4DFBBBD1.3020504@phy.duke.edu>
References: <4DFB6745.3040805@phy.duke.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4DFB6745.3040805@phy.duke.edu>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

On 06/17/2011 10:40 AM, Jimmy Dorff wrote:
> # here is my attempt at nesting another level
> dn: cn=project, ou=auto.phy,dc=phy,dc=duke,dc=edu
> objectClass: automount
> cn: project
> automountInformation: ldap ldapserver:ou=auto.project,dc=phy,dc=duke,dc=edu

My problem was the lack of "-fstype=autofs".

This works:
dn: cn=project,ou=auto.phy,dc=phy,dc=duke,dc=edu
objectClass: automount
cn: project
automountInformation: -fstype=autofs ou=auto.project,dc=phy,dc=duke,dc=edu

I also think this is called "layering" rather than "nesting".. but I'm 
not sure.

Cheers,
Jimmy
