From: Ondrej Valousek <webserv@s3group.cz>
Subject: Re: RHEL5 automount against LDAP Maps using basic
	authentication
Date: Tue, 06 Apr 2010 08:19:44 +0200
Message-ID: <4BBAD280.5020107@s3group.cz>
References: <4A961A51CBE84C429C56E5734477BD1F2B7D1AB63F@EXCHAMRS03.na.blkint.com>
	<1270278978.4021.14.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1270278978.4021.14.camel@localhost>
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
To: Ian Kent <raven@themaw.net>
Cc: "'autofs@linux.kernel.org'" <autofs@linux.kernel.org>

Automounter (as it currently stays) can not do simple authenticated 
binds against LDAP server. It can only do various types of SASL binds, 
so check out what type of SASL authentication your LDAP server supports....

Ondrej
